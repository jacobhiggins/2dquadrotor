%% Setup environment
clear all; close all;
addpath('./utils');
addpath('./utils/trajectories');

%% Choose trajectory to follow
trajHandle = @test;

%% Create simulation object
sim = Simulation(trajHandle);

%% Execute simulation
sim.execute();