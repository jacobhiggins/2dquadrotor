classdef Controller < handle
    properties
        % Properties
        dtPosCtrl = 0.1; % Time step for position controller
        dtAttCtrl = 0.02; % Time step for attitude controller
        
        % Trajectory to track
        pos = [];
        vel = [];
        acc = [];
        
        % Logic variables
        tPrevPosCtrl = 0;
        y_ddot_des = 0;
        z_ddot_des = 0;
        tPrevAttCtrl = 0;
        theta_des = 0;
        u = [0;0];
    end
    methods
        function obs = Controller()
            
        end
        function [pdes,vdes,ades] = posCtrl(obj,x,t)
            kp = 1; kv = 1;
            py = x(1); pz = x(2); vy = x(4); vz = x(5);
            
            if (t-obj.tPrevPosCtrl)>obj.dtPosCtrl
                obj.tPrevPosCtrl = t;
%                 obj.y_ddot_des = 
            end
        end
        function thetaDes = attCtrl(obj,state,t)
            
        end
        function [u1,u2] = getMotorSpeeds(obj,state,t)
            
        end
    end
end