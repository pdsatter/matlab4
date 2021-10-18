function value = ValidInput(prompt)
% Purpose: Prompts the user for input and then validates that input. If the value input by the user
% is not positive, prompts the user to reenter the input. If the input is still invalid after three
% attempts, either the absolute value is taken (if negative) or an error is thrown (if zero).
%
% Inputs:
%   prompt = the input prompt displayed to the user
% Outputs:
%   value = the value input by the user
%
% Remember that the above function header is only a template and the names of any input and/or
% output variables can be changed, if desired.
count = 1;
while count <= 3
    value = input(prompt);
    
    if value <= 0 % if value is invalid...
        count = count + 1;
    else % ends loops if value is valid
        break 
    end
    if count > 3 % If 3 attempts made...
        if value < 0 % Take abs val
            warning('Invalid value entered 3 times. Taking the abs value of the entered value');
            value = abs(value);
            break
        elseif value == 0  % Produce error if value == 0
            error('Entered value is zero. Cannot solve the problem, exiting program');
        end
    end
    
end

end