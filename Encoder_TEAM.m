function [encodedOutput, rotationOutput] = Encoder_TEAM(unencodedInput, customRotation)
%{
        Encoder_TEAM
            Caesar-shift a char array or a cell of char arrays

        Parameters
        ----------
        unencodedInput : char|cell
            Character array or character cell.
        rotationOutput : integer (optional)
            How much to rotate each unencodedInput

        Returns
        -------
        encodedOutput: char|cell
            Same data type as `unencodedInput`. Caesar-shifted chars.
        rotationOutput : cell
            An integer cell of respective rotations in case no custom rotation is given
%}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    inputType = class(unencodedInput);
    if strcmp(inputType, 'char')
        unencodedInput = { unencodedInput };
    end

    % Ranges for alphanumeric cases
    asciiUpper = [65 90];
    asciiLower = [97 122];
    asciiNumber = [48 57];
    charPool = [asciiUpper; asciiLower; asciiNumber];


    % Declare the outputs
    encodedOutput = {};
    rotationOutput = {};

    % Loop through the items to encode
    for cellIndex = 1:size(unencodedInput, 2)
        % Alias for referencing the current indexed string
        currString = unencodedInput{1, cellIndex};

        % If nothing to encode, then skip
        if size(currString, 2) == 0; continue; end

        % Declare the encoded counterpart
        encodedOutput{1, cellIndex} = '';

        if nargin == 2 % Check if a default rotation is set
            rotationOutput(1, cellIndex) = customRotation;
        else % Otherwise, make a random rotation key (offset to prevent output = unencodedInput)
            rotationOutput{1, cellIndex} = randi(24);
        end

        % Go char-by-char, encode alpha-num chars and leave others as-is
        for stringIndex = 1:size(currString, 2)
            % Alias for reference
            charCode = double(currString(stringIndex));

            % Pre-declare (in case no rotation)
            rotatedCode = charCode;

            % `mod` returns remainder of division; constrains respective char to its case
            for iCase = 1:size(charPool, 1)
                lowerRange = charPool(iCase, 1);
                upperRange = charPool(iCase, 2);
                % If within range, thene rotate
                if charCode >= lowerRange && charCode <= upperRange 
                    rotatedCode = lowerRange + ... % Account for offset
                        mod(charCode + rotationOutput{1, cellIndex} - ... % Add the rotation to the char code
                        lowerRange, ... % Offset for `mod` to loop within the range
                        upperRange - lowerRange); % Total range to get remainder within
                end
            end

            % Set encoded char @ repective index
            encodedOutput{1, cellIndex}(stringIndex) = char(rotatedCode);

        end

    end

    % If data to encode was given as char, output as char
    if strcmp(inputType, 'char')
        encodedOutput = encodedOutput{1, 1};
        rotationOutput = cell2mat(rotationOutput);
    end
end
