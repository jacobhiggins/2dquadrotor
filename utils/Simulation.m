classdef Simulation < handle
    properties
        % ---> Simulation properties
        t = 0; % Current simulation time
        T = 12; % Total simulation time
        dtSim = 0.02; % Simulation time step
        dtViz = 0.1; % Vizualization time step
        
        % ---> Objects
        traj; % Desired trajectory
        quad; % Quadrotor object
        ctrl; % Controller object
        viz; % Vizualization object
        
        % ---> Logic variables
        tLastViz = 0;
    end
    methods
        function obj = Simulation(trajHandle)
            obj.ctrl = Controller();
            obj.traj = trajHandle(obj.ctrl.dtPosCtrl);
            obj.ctrl.setTraj(obj.traj);
            obj.quad = Quadrotor();
            obj.viz = Vizualizer(obj.quad.x,obj.traj);
        end
        function execute(obj)
            while obj.t < obj.T
                obj.t = obj.t + obj.dtSim; % Increment sim time
                
                % Get controls u for current time step
%                 u = [9.8 9.8]/2.0;
                u = obj.ctrl.getMotorSpeeds(obj.quad.x,obj.t);
                
                % Simulate motion
                obj.quad.motionStep(u,obj.dtSim);
                
                % Vizualize
                if (obj.t - obj.tLastViz) >= 0.99*obj.dtViz
                    title(sprintf("Time: %0.2f",obj.t));
                    dt = obj.t-obj.tLastViz;
                    obj.tLastViz = obj.t;
                    
                    obj.viz.plotQuadFromState(obj.quad.x);
                    
                    pause(min(obj.dtViz,dt));
                end
                
                
            end
        end
    end
end