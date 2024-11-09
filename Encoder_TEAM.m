function [encodedOutput, rotationOutput] = Encoder_TEAM(input, customRotation)
    %{
        Encoder_TEAM
            Caesar-shift a char array or a cell of char arrays

        Parameters
        ----------
        input : char|cell
            Character array or character cell.
        rotationOutput : integer (optional)
            How much to rotate each input

        Returns
        -------
        encodedOutput: char|cell
            Same data type as `input`. Caesar-shifted chars.
        rotationOutput : cell
            An integer cell of respective rotations in case no custom rotation is given
            
        https://www.geeksforgeeks.org/python-docstrings/
    %}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    encodeType = class(input);
    if strcmp(encodeType, 'char')
        input = { input };
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
    for cellIndex = 1:size(input, 2)
        % Alias for referencing the current indexed string
        currString = input{1, cellIndex};

        % If nothing to encode, then skip
        if length(currString) == 0; continue; end

        % Declare the encoded counterpart
        encodedOutput{1, cellIndex} = '';

        if nargin == 2 % Check if a default rotation is set
            rotationOutput(1, cellIndex) = customRotation;
        else % Otherwise, make a random rotation key (offset to prevent output = input)
            rotationOutput{1, cellIndex} = randi(24);
        end

        % Go char-by-char, encode alpha-num chars and leave others as-is
        for stringIndex = 1:length(currString)
            % Alias for reference
            charCode = double(currString(stringIndex));

            % Pre-declare (in case no match)
            rotatedCode = charCode;

            % `mod` returns remainder of division; constrains respective char to its case
            for iCase = 1:size(charPool, 1)
                lowerRange = charPool(iCase, 1);
                upperRange = charPool(iCase, 2);
                if charCode >= lowerRange && charCode <= upperRange % Uppercase
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
    if strcmp(encodeType, 'char')
        encodedOutput = encodedOutput{1, cellIndex};
    end
end
%{
https://docs.octave.org/v4.0.0/Format-of-Descriptions.html#Format-of-Descriptions
https://docs.octave.org/v4.0.0/Octave-Sources-_0028m_002dfiles_0029.html#Octave-Sources-_0028m_002dfiles_0029
%}