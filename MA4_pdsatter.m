% Preston Satterfield
% pdsatter
% 1972081
% MA 4

%% TASK 1: : Material selection and data validation
% Import material array
% Prompt user to select material from Material array
%   If user exits, repeat menu until selected
%   (Use this to deterime ELASTICITY vector)
% input('Enter the length of the beam [m]: ');

load('MaterialElasticity.mat');
menuSelect = 0;
while menuSelect == 0
    menuSelect = menu('Select a material:', num2cell(Material));
end
E = Elasticity(menuSelect);

%% TASK 2: Dimensional information and data validation
% Write function VaildInput.m
%   Validates user's input
%   One input (like input() function)
%   One output
%   Data Validation:
%       val <= 0, prompt for new value, 
%       MAX 3 attempts then give WARNING and ABS VAL
%       IF last value == 0, GIVE ERROR\
% Call 3 times for length, width, and height
L = ('Enter the length of the beam [m]: ');
L = ValidInput(L);

w = ('Enter the width of the beam [m]: ');
w = ValidInput(w);

h = ('Enter the height of the beam [m]: ');
h = ValidInput(h);

%% TASK 3:  Calculate deflection for a single load on a simply supported beam
% input concentrated force, F[N], and location of fore, a[m].
% Include L in statement
% Use eq 1 - 4 to determine the deflection curve across the beam
% plot deflection as a solid line
% format plot

% Prompt user to input Force and a (distance)
F = input('Enter the magnitude of a concentraded force acting on the beam [N]: ');
promptA = 'Enter the location of the force (0 - ' + string(L) + ' meters): ';
a = input(promptA);

%% Use Eq 2-4 to solve I,R, and theta
I = w * (h^3) / 12;  % Eq 2
R = (F/L) * (L - a);  % Eq 3
theta = ((F * a) / (6 * E * I * L)) * (2 * L - a) * (L - a);  % Eq 4
x = (0:0.1:L);

Deflection = zeros(1,length(x));
val = 0;
count = 1;
for x = (0:0.1:L)
    % Eq 1
    
    if x <= a
       val = (-1 * theta* x) + ((R * x^3)/(6 * E * I));
    else
        val = (-1 * theta* x) + ((R * x^3)/(6 * E * I)) - ((F * power(x-a,3))/ (6*E*I));
    end
    Deflection(count) = val;
    count = count + 1;
end
Deflection = Deflection * 1000;

%% TASK 4: Calculate deflection for multiple loads on a simply supported beam
% 
%

isTrue = true;
plotAgain = false;
while isTrue == true
    FVector = input('Enter the magnitudes of multiple loads on the beam [N]: ');
    promptA = 'Enter the locations of the forces, in order (0 - ' + string(L) + 'meters): ';
    aVector = input(promptA);

    % IVector = zeros(1, length(FVector)); I is constant
    RVector = zeros(1, length(FVector));
    thetaVector = zeros(1, length(FVector));

    % NEW ATTEMPT
    row = 1;
    %  I = w * (h^3) / 12;  % Eq 2
    x = (0:0.1:L);
    Deflection2 = zeros(length(aVector),length(x));
    tempDeflection2 = Deflection2;
    
    while row <= length(aVector)
        RVector(row) = (FVector(row)/L) * (L - aVector(row));  % Eq 3
        thetaVector(row) = ((FVector(row) * aVector(row)) / (6 * E * I * L)) * (2 * L - aVector(row))...
            * (L - aVector(row));  % Eq 4
    
        val = 0;
        col = 1;
        for x = (0:0.1:L)
            % Eq 1
            if x <= aVector(row)
                val = (-1 * thetaVector(row)* x) + ((RVector(row) * x^3)/(6 * E * I));
            else
                val = (-1 * thetaVector(row)* x) + ((RVector(row) * x^3)/...
                    (6 * E * I)) - ((FVector(row) * power((x-aVector(row)),3))/ (6*E*I));
            end
            Deflection2(row,col) = val;
            col = col + 1;
        end
        row = row + 1;
    end
        Deflection2 = Deflection2 * 1000;
        Deflection2 = sum(Deflection2);
        fprintf('The maximum deflection of the beam is %.3f [mm]. \n', abs(min(Deflection2)))

    %% Plot
    %  numPlotted = 2;
    % PLOT 1
    subplot(1,2,1)
	x = (0:0.1:L);
    y = Deflection;
    plot(x,y)

    xlabel('Beam Location (x)[m]')
    ylabel('Deflection of Beam (y)[mm]')
    xlim([0,L])
    title('Deflection of' + Material(menuSelect) + 'Beam Under a Concentrated Load')
    grid on
    
    %PLOT 2
        x = (0:0.1:L);
        y2 = Deflection2;
    subplot(1,2, 2);
    plot(x,y2)
    
    xlabel('Beam Location (x)[m]')
    ylabel('Deflection of Beam (y)[mm]')
    xlim([0,L])
    title('Deflection of' + Material(menuSelect) + 'Beam Under a Concentrated Load')
    grid on

    menu1 = 0;
    while menu1 == 0
        menu1 = menu('Input again? ', 'Yes', 'No');
    end
    if menu1 == 1
        isTrue = true;
    else
        isTrue = false;
    end
    
end

