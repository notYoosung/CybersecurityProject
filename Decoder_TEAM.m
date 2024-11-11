function [decodedOutput] = Decoder_TEAM(encodedInput, key)
%{
        Decoder_TEAM
            Select characters from excrypted char matrices with a key

        Parameters
        ----------
        encodedInput : char|cell
            Intended to be first output of `Encoder_TEAM.m`. A Character array or character cell. 
        key : vec|cell
            Intended to be second output of `Encoder_TEAM.m`. Contains the indecies of the decrypted output.

        Returns
        -------
        decodedOutput: char|cell
            Same data type as `encodedInput`.
            
%}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    inputType = class(encodedInput);
    if strcmp(inputType, 'char')
        encodedInput = { encodedInput };
    end
    if strcmp(class(key), 'double')
        key = num2cell(key);
    end

    % Ranges for alphanumeric cases
    asciiUpper = [65 90];
    asciiLower = [97 122];
    asciiNumber = [48 57];
    charPool = [asciiUpper; asciiLower; asciiNumber];

    % Declare the output
    decodedOutput = {};

    % Loop through each input
    for iInput = 1:size(encodedInput, 2)
        % Declare respective output
        decodedOutput{1, iInput} = '';

        % Aliases for current indices
        currRotation = key{1, iInput};
        currString = encodedInput{1, iInput};

        % If there's nothing, then skip
        if length(currString) == 0
            continue
        end

        % Alias for the current key
        currKey = key{1, iInput};

        % Go through the string and rotate the char codes
        for iString = 1:length(currString)        
            % Convert the char into its ASCII code
            charCode = double(currString(iString));

            % Pre-declare (in case no rotation)
            rotatedCode = charCode;
            

            for iCase = 1:size(charPool, 1)
                lowerRange = charPool(iCase, 1);
                upperRange = charPool(iCase, 2);
                % If within range, then rotate
                if charCode >= lowerRange && charCode <= upperRange
                    rotatedCode = lowerRange + ... % Account for offset
                        mod(charCode - currKey - ... % Add the rotation to the char code
                        lowerRange, ... % Offset for `mod` to loop within the range
                        upperRange - lowerRange); % Total range to get remainder within
                end
            end

            % After rotation, convert ASCII code to char
            decodedOutput{1, iInput}(iString) = char(rotatedCode);

        end

    endfor

    % If data to encode was given as char, output as char
    if strcmp(inputType, 'char')
        decodedOutput = decodedOutput{1, 1};
    end

endfunction
