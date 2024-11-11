function [encryptedOutput, encryptedKeys] = Encrypt_TEAM(unencryptedInput)
%{
        Encrypt_TEAM
            Mix a char array or a cell of char arrays with a random amount of random alphanumeric characters

        Parameters
        ----------
        unencryptedInput : char|cell[char]
            Character array or character cell.

        Returns
        -------
        encryptedOutput: char|cell(char)
            Char or char cell of random characters with the original unencryptedInput scattered within. Same data type as `unencryptedInput`.
        encryptedKeys : mat|cell(int)
            A vector matrix or cell of integer cells for respective keys for the output
            
        https://www.geeksforgeeks.org/python-docstrings/
%}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    encodeType = class(unencryptedInput);
    if strcmp(encodeType, 'char')
        unencryptedInput = { unencryptedInput };
    end

    % Ranges for alphanumeric cases
    asciiUpper = [65:90];
    asciiLower = [97:122];
    asciiNumber = [48:57];
    charPool = [asciiUpper asciiLower asciiNumber];

    % Declare the outputs
    encryptedOutput = {};
    encryptedKeys = {};

    % Loop through the items to encrypt
    for iCell = 1:size(unencryptedInput, 2)
        originalString = unencryptedInput{1, iCell};
        % Declare a new index in the outputs
        encryptedOutput{1, iCell} = {};
        encryptedKeys{1, iCell} = {};

        % Declare & make legible alias for encrypted output
        encryptedString = '';
        key = {};

        % Loop through each unencryptedInput and add encryption
        for i = 1:size(originalString, 2)
            % According to assignment, encrypt with up to 10 random separating characters
            sepLen = randi(10);

            % Populate string
            for sep = 1:sepLen
                % Next index of string is random selection of alphanum pool
                randSel = charPool(randi(size(charPool, 2)));
                encryptedString = [encryptedString char(randSel)];
            end

            % Next index of string is char from original string
            key(1, end + 1) = size(encryptedString, 2) + 1;
            encryptedString = [encryptedString, originalString(i)];
            % Store index for key
        end

        % Re-populate end of string to prevent a the last char = last original char
        for sep = 1:randi(10)
            randSel = charPool(randi(size(charPool, 2)));
            encryptedString = [encryptedString char(randSel)];
        end

        % Assign the aliases to their respective outputs
        encryptedOutput{1, iCell} = encryptedString;
        encryptedKeys{1, iCell} = key;
    end


    % If data to encode was given as char, convert output to char & keys to vector matrix
    if strcmp(encodeType, 'char')
        encryptedOutput = encryptedOutput{1, 1};
        encryptedKeys = cell2mat(encryptedKeys{1, 1});
    end

end
