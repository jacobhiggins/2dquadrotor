function traj = right(dt)
    % Use trajectory object to get trajectory
    T = 4;
    
    p0 = [ 0 0 ];
    v0 = [ 0 0 ];
    a0 = [ 0 0 ];
    pT = [ 4 0 ];
    vT = [ 0 0 ];
    aT = [ 0 0 ];
    boundaryConds = [p0;v0;a0;pT;vT;aT];
    
    traj = SingleSegTraj2D(T,boundaryConds);
    
    % Define limits for plotting
    traj.xlims = [-1 5];
    traj.ylims = [-1 1];
 
    traj.definePoints(dt);
    
end