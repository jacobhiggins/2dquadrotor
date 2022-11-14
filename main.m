%% Setup environment
clear all; close all;
addpath('./utils');
addpath('./utils/trajectories');

%% Choose trajectory to follow
% trajHandle = @test;
% trajHandle = @up;
% trajHandle = @right;
trajHandle = @upAndRight;

%% Create simulation object
sim = Simulation(trajHandle);

%% Execute simulation
sim.execute();