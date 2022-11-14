classdef Trajectory2D < handle
    properties
        duration;
        dt;
        ts; % time steps
        pos;
        vel;
        acc;
        xlims;
        ylims;
    end
    methods
        function obj = Trajectory2D()
            
        end
        function setTs(obj,ts)
            obj.ts = ts;
        end
        function setPVA(obj,pos,vel,acc)
            % Set position, velocity, acceleration
            obj.pos = pos;
            obj.vel = vel;
            obj.acc = acc;
        end
    end
end