classdef SingleSegTraj2D < Trajectory2D
    properties
        trajDirs;
    end
    methods
        function obj = SingleSegTraj2D(duration,boundaryConds)
            obj@Trajectory2D();
            obj.duration = duration;
            obj.defineDirs(boundaryConds);
        end
        function defineDirs(obj,boundaryConds)
            % Define trajectory in xyz directions
            % boundaryConds = [ bcs_x bcs_y bcs_z ] - ( 6 x 3 )
            for i = 1:2
                obj.trajDirs{i} = SingleSegTraj1D(obj.duration,boundaryConds(:,i));
            end
        end
        function definePoints(obj,dt)
            for i = 1:2
                [posDir,velDir,accDir,ts] = obj.trajDirs{i}.getPoints(dt);
                pos(i,:) = posDir;
                vel(i,:) = velDir;
                acc(i,:) = accDir;
            end
            obj.setTs(ts);
            obj.setPVA(pos,vel,acc);
        end
    end
end