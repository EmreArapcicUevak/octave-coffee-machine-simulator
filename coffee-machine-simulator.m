% Clear junk variables
clear all;
clc;

% Close other frames
close all;

% Initilize needed variables
primaryColor = '#f2b085'; secondaryColor = '#85c7f2'; textColor = '#77AC30';
data.coffeeCount = ones(1,6);

% Set up all needed frames
mainFrame = figure('position', [0 0 700 500], 'Name', 'Coffe Machine', 'NumberTitle', 'off');
titleFrame = uipanel('Parent', mainFrame, 'position', [0 .85 1 .15]);

rightHalf = uipanel('Parent', mainFrame, 'position', [0.5 0 0.5 .85]);
keypadFrame = uipanel('Parent', rightHalf, 'position', [0.05 0.3 0.5 0.5]);
coffeSlotFrame = uipanel('Parent', rightHalf, 'position', [0.5-0.35/2 0.025 0.35 0.23]);
coinSlotFrame = uipanel('Parent', rightHalf, 'position', [0.6 0.35 0.0750 0.4]);

leftHalf = uipanel('Parent', mainFrame, 'position', [0 0 .5 0.85]);
coffeeMenu = uipanel('Parent', leftHalf, 'position', [0.025 0.05 0.95 .9]);

% Set up all elements
consoleOutput = uicontrol(rightHalf, 'Style', 'edit', 'units', 'normalized' ,"string", "plot title: (text)","position", [0.05 0.85 0.9 0.13], 'Max', 5, 'Min', 0, 'enable', 'off');


guidata(mainFrame, data);
set(consoleOutput,'string', 'test');
