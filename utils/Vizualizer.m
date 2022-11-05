classdef Vizualizer < handle
    properties
        % ---> Quadrotor viz properties
        quadL = 0.5;
        
        % ---> Plotting objects
        initPlot = 0;
        plt_quad_dots; % Plot of quadrotor, dots
        plt_quad_line; % Plot of quadrotor, line
    end
    methods
        function obj = Vizualizer(x,trajHandle)
            % Main plot
            figure(1); hold on;
            axis equal;
            [xlims,ylims] = trajHandle(); xlim(xlims); ylim(ylims);
            
            obj.plotQuadFromState(x);
            
            % State components plot
        end
        function plotQuadFromState(obj,x)
            % Dots of quadrotor
            dots = obj.getQuadDotsFromState(x);
            if ~obj.initPlot
                obj.plt_quad_dots = scatter(dots(1,:),dots(2,:),20,'b','filled');
                obj.plt_quad_line = plot(dots(1,:),dots(2,:),...
                    'LineWidth',2,...
                    'Color','b');
                obj.initPlot = 1;
            else
                obj.plt_quad_dots.XData = dots(1,:);
                obj.plt_quad_dots.YData = dots(2,:);
                obj.plt_quad_line.XData = dots(1,:);
                obj.plt_quad_line.YData = dots(2,:);
            end
            % Line of quadrotor
        end
        function dots = getQuadDotsFromState(obj,x)
            py = x(1); pz = x(2); theta = x(3);
            % Body-frame
            dots = [0 0;            % Center dot
                    obj.quadL 0;    % Right dot
                    -obj.quadL 0]'; % Left dot
            % Rotation
            R = [cos(theta) -sin(theta);
                sin(theta) cos(theta)];
            dots = R*dots;
            % Offset by COM position
            dots = dots + [py;pz];
            
        end
    end
end