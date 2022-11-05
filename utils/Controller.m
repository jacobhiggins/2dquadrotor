classdef Controller < handle
    properties
        % Properties
        dtPosCtrl = 0.1; % Time step for position controller
        dtAttCtrl = 0.02; % Time step for attitude controller
        
        % Logic variables
        y_ddot_des = 0;
        z_ddot_des = 0;
        u = [0;0];
    end
    methods
        function obs = Controller()
            
        end
        function [pdes,vdes,ades] = posCtrl()
            
        end
    end
end