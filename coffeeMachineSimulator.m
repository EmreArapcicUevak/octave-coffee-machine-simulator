function coffeeMachineSimulator()

  # Clear junk variables
  clear all;
  clc;

  # Close other frames
  close all;

  # Set up the GUI of the application
  setupGUI();

  # Starts the application process
  pause(1);
  data = guidata(gcf());
  set(data.consoleOutput, "string", "Please select the coffee you want");
  data.enableButtons = 1;
  data.enableNumbers = 1;
  guidata(gcf(), data);

endfunction


function setupGUI()

  # Initilize needed variables
  primaryColor = '#787878'; secondaryColor = '#cdcdcd'; textColor = '#77AC30';
  data.coffeeOrderButtons = [];
  data.coffeeNames = cell(1, 6);
  data.coffeeNames{1} = "Black Coffee";
  data.coffeeNames{2} = "Coffee Light";
  data.coffeeNames{3} = "Cafe Late";
  data.coffeeNames{4} = "Cappuccino";
  data.coffeeNames{5} = "Cafe Mocha";
  data.coffeeNames{6} = "Hot Chocolate";
  data.coffeeNames{7} = "Americano";
  data.coffeeNames{8} = "Espresso";
  data.coffeeNames{9} = "Choco Milk";
  data.coffeePrice{1} = 1;
  data.coffeePrice{2} = 1.5;
  data.coffeePrice{3} = 3.25;
  data.coffeePrice{4} = 2;
  data.coffeePrice{5} = 5.65;
  data.coffeePrice{6} = 0.80;
  data.coffeePrice{7} = 10.95;
  data.coffeePrice{8} = 4.20;
  data.coffeePrice{9} = 0.80;
  data.coffeePaid = 0;
  data.hasChange = 0;
  data.enableButtons = 0;
  data.enableNumbers = 0;
  data.enableInteractions = 0;
  data.number = "";
  data.numberEntered = 0;
  data.askForExtraSugar = 0;
  data.askForExtraMilk = 0;
  data.extraMilk = 0;
  data.extraSugar = 0;
  data.coffeeFinished = 0;

  # Set up all needed frames
  mainFrame = figure('position', [0 0 800 600], 'Name', 'Coffee Machine', 'NumberTitle', 'off','color', primaryColor,'toolbar','none', 'resize', 'off');
  titleFrame = uipanel('Parent', mainFrame, 'position', [0 .85 1 .15],'HighLightColor', primaryColor);

  rightHalf = uipanel('Parent', mainFrame, 'position', [0.5 0 0.5 .85],'backgroundcolor', primaryColor, 'HighLightColor', primaryColor );
  keypadFrame = uipanel('Parent', rightHalf, 'position', [0.05 0.3 0.5 0.5],'HighLightColor', primaryColor );
  coffeSlotFrame = uipanel('Parent', rightHalf, 'position', [0.6 0.3 0.35 0.5],'HighLightColor', primaryColor );

  leftHalf = uipanel('Parent', mainFrame, 'position', [0 0 .5 0.85],'backgroundcolor', primaryColor ,'HighLightColor', primaryColor );
  coffeeMenu = uipanel('Parent', leftHalf, 'position', [0.025 0.05 0.95 .9], 'backgroundcolor', primaryColor,'HighLightColor', primaryColor );

  # Set up all elements
  data.consoleOutput = uicontrol(rightHalf, 'Style', 'edit', 'units', 'normalized' ,"string", "IUS Coffee Machine","position", [0.05 0.85 0.9 0.13], 'Max', 5, 'Min', 0, 'enable', 'off',"backgroundcolor", "#000000");

  # Set up title
  uicontrol('parent', titleFrame, 'Style', 'text', 'units', 'normalized' ,"string", "IUS COFFEE","position", [0 0 1 1], 'backgroundcolor', primaryColor, 'fontsize', 18);

  # Set up menubar
  interactions = uimenu("Text", "Interactions");
  interactionsItem1 = uimenu(interactions, "Text", "Insert 5KM", 'callback', { @interactionPressed, "5         " });
  interactionsItem2 = uimenu(interactions, "Text", "Insert 2KM", 'callback', { @interactionPressed, "2         " });
  interactionsItem3 = uimenu(interactions, "Text", "Insert 1KM", 'callback', { @interactionPressed, "1         " });
  interactionsItem4 = uimenu(interactions, "Text", "Insert 50F", 'callback', { @interactionPressed, "0.5       " });
  interactionsItem5 = uimenu(interactions, "Text", "Insert 20F", 'callback', { @interactionPressed, "0.2       " });
  interactionsItem6 = uimenu(interactions, "Text", "Insert 10F", 'callback', { @interactionPressed, "0.1       " });
  interactionsItem7 = uimenu(interactions, "Text", "Insert 5F", 'callback', { @interactionPressed, "0.05      " });
  interactionsItem8 = uimenu(interactions, "Text", "Take the coffee", 'callback', { @interactionPressed, "takeCoffee" });
  interactionsItem9 = uimenu(interactions, "Text", "Take the change", 'callback', { @interactionPressed, "takeChange" });

  # Set up KeyPad Buttons
  for i = 1:4
	  for j = 1:3
		  if (i != 4)
			  uicontrol(keypadFrame, 'Style', 'pushbutton', 'units', 'normalized' ,"string", num2str(3*(i-1) + j - 1), 'callback', { @buttonPressed, num2str(3*(i-1) + j - 1) }, "position", [1/3*(j-1) 1-1/4*i 1/3 1/4], 'Max', 5, 'Min', 0, 'enable', 'on', 'fontsize', 14, 'backgroundcolor', secondaryColor);
		  else
			  if (j == 2)
				  uicontrol(keypadFrame, 'Style', 'pushbutton', 'units', 'normalized' ,"string", "9", 'callback', { @buttonPressed, "9" }, "position", [1/3 0 1/3 1/4], 'Max', 5, 'Min', 0, 'enable', 'on', 'fontsize', 14,'backgroundcolor', secondaryColor);
			  elseif (j == 1)
				  uicontrol(keypadFrame, 'Style', 'pushbutton', 'units', 'normalized' ,"string", "Yes", 'callback', { @buttonPressed, "yes" }, "position", [0 0 1/3 1/4], 'Max', 5, 'Min', 0, 'enable', 'on', 'fontsize', 14,'backgroundcolor', secondaryColor);
			  else
				  uicontrol(keypadFrame, 'Style', 'pushbutton', 'units', 'normalized' ,"string", "No", 'callback', { @buttonPressed, "no " }, "position", [2/3 0 1/3 1/4], 'Max', 5, 'Min', 0, 'enable', 'on', 'fontsize', 14,'backgroundcolor', secondaryColor);
			  end
		  end
	  end
  end

  # Set up for coffee menu
  for i = 1:3
	  for j = 1:3
		  if (3*(i-1) + j > length(data.coffeeNames)) break; end
		  coffeeFrame = uipanel('Parent', coffeeMenu, 'position', [(j-1)/3 1-i/3 1/3 1/3],'HighLightColor', primaryColor , 'backgroundcolor',primaryColor );
		  axes('Parent', coffeeFrame,'position', [0 0.4 1 0.6], 'xtick', [], 'ytick', [], 'xlim', [0 1], 'ylim', [0 1], 'Color', primaryColor);
		  imshow(strcat('./Images/', data.coffeeNames{3*(i-1) + j}, '.png'), []);
		  uicontrol(coffeeFrame, 'Style', 'text', 'units', 'normalized' ,"string", num2str(3*(i-1) + j), "position", [0 0.2 1 0.2], 'enable', 'on', 'fontsize', 14, 'backgroundcolor',primaryColor );
		  uicontrol(coffeeFrame, 'Style', 'text', 'units', 'normalized' ,"string", data.coffeeNames{3*(i-1) + j}, "position", [0 0 1 0.2], 'enable', 'on', 'fontsize', 14, 'backgroundcolor',primaryColor );
	  end
  end

  guidata(mainFrame, data);

endfunction


function buttonPressed(hObject, eventdata, value)

  data = guidata(gcf());

  if (data.enableButtons != 1)
    return;
  endif

  if (value == "yes")

    if (data.askForExtraMilk == 1)
      data.askForExtraMilk = 0;
      data.askForExtraSugar = 0;
      data.extraMilk = 1;
      pause(1);
      set(data.consoleOutput, "string", cstrcat("The total is ", num2str(data.coffeePrice{str2num(data.number)}), "KM"));
      data.enableButtons = 0;
      data.enableInteractions = 1;
    endif

    if (data.askForExtraSugar == 1)
      data.askForExtraSugar = 0;
      data.extraSugar = 1;
      pause(1);
      set(data.consoleOutput, "string", "Do you want extra milk?");
      data.askForExtraMilk = 1;
    endif

    if (data.numberEntered == 0)
        if (str2num(data.number) == 1 || str2num(data.number) == 2 || str2num(data.number) == 3 || str2num(data.number) == 4 || str2num(data.number) == 5 || str2num(data.number) == 6 || str2num(data.number) == 7 || str2num(data.number) == 8 || str2num(data.number) == 9)
          set(data.consoleOutput, "string", strcat(data.coffeeNames{str2num(data.number)}, " selected."));
          pause(1);
          data.numberEntered = 1;
          data.enableNumbers = 0;
          set(data.consoleOutput, "string", "Do you want extra sugar?");
          data.askForExtraSugar = 1;
        else
          set(data.consoleOutput, "string", "Wrong number entered.");
          pause(2);
          data.number = "";
          set(data.consoleOutput, "string", data.number);
        endif
    else

    endif
  elseif (value == "no ")

    if (data.askForExtraMilk == 1)
      data.askForExtraMilk = 0;
      data.askForExtraSugar = 0;
      data.extraMilk = 0;
      pause(1);
      set(data.consoleOutput, "string", cstrcat("The total is ", num2str(data.coffeePrice{str2num(data.number)}), "KM"));
      data.enableButtons = 0;
      data.enableInteractions = 1;
    endif

    if (data.askForExtraSugar == 1)
      data.askForExtraSugar = 0;
      data.extraSugar = 0;
      pause(1);
      set(data.consoleOutput, "string", "Do you want extra milk?");
      data.askForExtraMilk = 1;
    endif

    if (data.numberEntered == 0)
      data.number = "";
      set(data.consoleOutput, "string", data.number);
    else

    endif
  else
    if (data.enableNumbers == 0)
      return;
    endif
    data.number = strcat(data.number, value);
    set(data.consoleOutput, "string", data.number);
  endif

  guidata(gcf(), data);

endfunction

function interactionPressed(hObject, eventdata, value)

  data = guidata(gcf());

  if (value == "takeCoffee")
    if (data.coffeeFinished == 1)
      set(data.consoleOutput, "string", "Enjoy your coffee.");
      pause(2);
      close;
    else
      return;
    endif
  endif

  if (value == "takeChange")
    if (data.hasChange == 1)
      data.coffeeFinished = 1;
      data.hasChange = 0;
      set(data.consoleOutput, "string", "Please wait while the coffee is being made.");
      pause(1);

      [y, fs] = audioread("./Audio/CoffeeMakerSound.wav");
      player = audioplayer(y, fs);
      playblocking(player);
      [y, fs] = audioread("./Audio/CoffeeDoneSound.wav");
      player = audioplayer(y, fs);
      playblocking(player);

      if (data.extraSugar == 1 && data.extraMilk == 1)
        set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, " with extra sugar and extra milk."));
      elseif(data.extraSugar == 1 && data.extraMilk == 0)
        set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, " with extra sugar."));
      elseif(data.extraSugar == 0 && data.extraMilk == 1)
        set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, " with extra milk."));
      else
        set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, "."));
      endif
      pause(2);
      set(data.consoleOutput, "string", "Please take your coffee.");
    else
      return;
    endif
  endif

  guidata(gcf(), data);

  if (data.coffeePaid == 1)
    return;
  endif

  numValue = str2num(value);
  data.coffeePrice{str2num(data.number)} -= numValue;
  strValue = num2str(data.coffeePrice{str2num(data.number)});

  if (data.coffeePrice{str2num(data.number)} > 0)
    set(data.consoleOutput, "string", strcat(strValue, "KM left to enter."));
  elseif (data.coffeePrice{str2num(data.number)} == 0)
    set(data.consoleOutput, "string", "Please wait while the coffee is being made.");
    data.coffeePaid = 1;
    pause(1);

    #Anim = imshow("./Animations/finalCoffeeVideo.gif");

    [y, fs] = audioread("./Audio/CoffeeMakerSound.wav");
    player = audioplayer(y, fs);
    playblocking(player);
    [y, fs] = audioread("./Audio/CoffeeDoneSound.wav");
    player = audioplayer(y, fs);
    playblocking(player);

    data.coffeeFinished = 1;
    if (data.extraSugar == 1 && data.extraMilk == 1)
      set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, " with extra sugar and extra milk."));
    elseif(data.extraSugar == 1 && data.extraMilk == 0)
      set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, " with extra sugar."));
    elseif(data.extraSugar == 0 && data.extraMilk == 1)
      set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, " with extra milk."));
    else
      set(data.consoleOutput, "string", cstrcat("Here is your ", data.coffeeNames{str2num(data.number)}, "."));
    endif
    pause(2);
    set(data.consoleOutput, "string", "Please take your coffee.");
  else
    set(data.consoleOutput, "string", "Please take your change");
    data.hasChange = 1;
    data.coffeePaid = 1;
  endif

  guidata(gcf(), data);

endfunction
