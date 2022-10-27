classdef Quadrotor < handle
    properties
        x; % State = [py, pz, theta, vy, vz, thetadot]^T
    end
    methods
        function obj = Quadrotor()
            obj.x = [0 0 pi/4 0 0 0]'; % Initialize state at origin
        end
        function xdot = EOM(obj,u)
            xdot = zeros(6,1); % Initialize state time derivative
            
            xdot(2) = 0.1;
        end
        function motionStep(obj,u,dt)
            [ts,xs] = ode45(@obj.EOM,[0 dt],obj.x);
            obj.x = xs(end,:)';
        end
    end
end