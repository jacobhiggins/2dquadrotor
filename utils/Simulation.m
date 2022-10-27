classdef Simulation < handle
    properties
        % ---> Simulation properties
        T = 10; % Total simulation time
        dtSim = 0.02; % Simulation time step
        dtViz = 0.1; % Vizualization time step
        
        % ---> Objects
        trajHandle; % Handle for desired trajectory
        quad; % Quadrotor object
        viz; % Vizualization object
    end
    methods
        function obj = Simulation(trajHandle)
            obj.trajHandle = trajHandle;
            obj.quad = Quadrotor();
            obj.viz = Vizualizer(obj.quad.x,trajHandle);
        end
        function execute(obj)
            
        end
    end
end