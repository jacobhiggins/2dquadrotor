classdef Controller < handle
    properties
        % Controller times
        dtPosCtrl = 0.1; % Time step for position controller
        dtAttCtrl = 0.02; % Time step for attitude controller
        
        % Trajectory to track
        dtTraj;
        ts;
        pos;
        vel;
        acc;
        
        % Logic variables
        % -> High level pos control
        tPrevPosCtrl = 0;
        y_ddot_des = 0;
        z_ddot_des = 0;
        % -> Attitude level control
        tPrevAttCtrl = 0;
        theta_des = 0;
        % -> Low level motor control
        thrust = 9.8;
        roll = 0.0;
    end
    methods
        function obj = Controller()
            
        end
        function setTraj(obj,traj)
            obj.dtTraj = traj.dt;
            obj.ts = traj.ts;
            obj.pos = traj.pos;
            obj.vel = traj.vel;
            obj.acc = traj.acc;
        end
        function posCtrl(obj,x,t)
            kpy = 0.5; kvy = 0.5;
            kpz = 2; kvz = 0.8;
            py = x(1); pz = x(2); vy = x(4); vz = x(5);
            
            N = length(obj.ts); % Number of time steps in trajectory
            
            if (t-obj.tPrevPosCtrl)>obj.dtPosCtrl
                obj.tPrevPosCtrl = t;
                
                tIdx = min(int16(t/obj.dtTraj),N);
                
                py_des = obj.pos(1,tIdx);
                pz_des = obj.pos(2,tIdx);
                vy_des = obj.vel(1,tIdx);
                vz_des = obj.vel(2,tIdx);
                ay_des = obj.acc(1,tIdx);
                az_des = obj.acc(2,tIdx);
                
                obj.y_ddot_des = ay_des + kpy*(py_des - py) + kvy*(vy_des - vy);
                obj.z_ddot_des = az_des + kpz*(pz_des - pz) + kvz*(vz_des - vz) + 9.8;
                
                obj.thrust = norm([obj.y_ddot_des,obj.z_ddot_des]);
                obj.theta_des = -atan2(obj.y_ddot_des,obj.z_ddot_des);
            end
        end
        function attCtrl(obj,x,t)
            theta = x(3); thetadot = x(6);
            kp = 20; kv = 2;
            
            if (t-obj.tPrevAttCtrl)>obj.dtAttCtrl
                obj.tPrevAttCtrl = t;
                obj.roll = kp*(obj.theta_des - theta) - kv*thetadot;
            end
            
            
        end
        function u = getMotorSpeeds(obj,x,t)
            
            % -> High level controller
            obj.posCtrl(x,t);
            % -> Low level controller
            obj.attCtrl(x,t);
            
            % T = u1 + u2;
            % M = u1 - u2;

            M = [1 1;1 -1];
            x = [obj.thrust;obj.roll];
            
            u = M\x;
            
        end
    end
end