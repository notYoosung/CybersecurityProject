function [EncodedOutput, RotationOutput] = Encoder_TEAM(Input, CustomRotation)
    %{
        Encoder_TEAM
            Caesar-shift a char array or a cell of char arrays

        Parameters
        ----------
        Input : char|cell
            Character array or character cell.
        RotationOutput : integer (optional)
            How much to rotate each input

        Returns
        -------
        EncodedOutput: char|cell
            Same data type as `Input`. Caesar-shifted chars.
        RotationOutput : cell
            An integer cell of respective rotations in case no custom rotation is given
            
        https://www.geeksforgeeks.org/python-docstrings/
    %}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    EncodeType = class(Input);
    if strcmp(EncodeType, 'char')
        Input = { Input };
    end

    % Ranges for alphanumeric cases
    ASCIIUpper = [65 90];
    ASCIILower = [97 122];
    ASCIINumber = [48 57];
    CharPool = [ASCIIUpper; ASCIILower; ASCIINumber];


    % Declare the outputs
    EncodedOutput = {};
    RotationOutput = {};

    % Loop through the items to encode
    for CellIndex = 1:size(Input, 2)
        % Alias for referencing the current indexed string
        String = Input{1, CellIndex};

        % If nothing to encode, then skip
        if length(String) == 0; continue; end

        % Declare the encoded counterpart
        EncodedOutput{1, CellIndex} = '';

        if nargin == 2 % Check if a default rotation is set
            RotationOutput(1, CellIndex) = CustomRotation;
        else % Otherwise, make a random rotation key (offset to prevent output = input)
            RotationOutput{1, CellIndex} = randi(24);
        end

        % Go char-by-char, encode alpha-num chars and leave others as-is
        for StringIndex = 1:length(String)
            % Alias for reference
            Code = double(String(StringIndex));

            % Pre-declare (in case no match)
            RotatedCode = Code;

            % `mod` returns remainder of division; constrains respective char to its case
            for iCase = 1:size(CharPool, 1)
                LowerRange = CharPool(iCase, 1);
                UpperRange = CharPool(iCase, 2);
                if Code >= LowerRange && Code <= UpperRange % Uppercase
                    RotatedCode = LowerRange + ... % Account for offset
                        mod(Code + RotationOutput{1, CellIndex} - ... % Add the rotation to the char code
                        LowerRange, ... % Offset for `mod` to loop within the range
                        UpperRange - LowerRange); % Total range to get remainder within
                end
            end

            % Set encoded char @ repective index
            EncodedOutput{1, CellIndex}(StringIndex) = char(RotatedCode);

        end

    end

    % If data to encode was given as char, output as char
    if strcmp(EncodeType, 'char')
        EncodedOutput = EncodedOutput{1, CellIndex};
    end
end
