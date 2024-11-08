function [EncryptedOutput, EncryptedKeys] = Encrypt_TEAM(Input)
    %{
        Encrypt_TEAM
            Mix a char array or a cell of char arrays with a random amount of random alphanumeric characters

        Parameters
        ----------
        Input : char|cell[char]
            Character array or character cell.

        Returns
        -------
        EncryptedOutput: char|cell(char)
            Char or char cell of random characters with the original input scattered within. Same data type as `Input`.
        EncryptedKeys : mat|cell(int)
            A vector matrix or cell of integer cells for respective keys for the output
            
        https://www.geeksforgeeks.org/python-docstrings/
    %}

    % Compatibility for either batch-encoding a cell or encoding a single char array
    EncodeType = class(Input);
    if strcmp(EncodeType, 'char')
        Input = { Input };
    end

    % Ranges for alphanumeric cases
    ASCIIUpper = [65:90];
    ASCIILower = [97:122];
    ASCIINumber = [48:57];
    CharPool = [ASCIIUpper ASCIILower ASCIINumber];

    % Declare the outputs
    EncryptedOutput = {};
    EncryptedKeys = {};

    % Loop through the items to encrypt
    for iCell = 1:size(Input, 2)
        OriginalString = Input{1, iCell}
        % Declare a new index in the outputs
        EncryptedOutput{1, iCell} = {};
        EncryptedKeys{1, iCell} = {};

        % Declare & make legible alias for encrypted output
        EncryptedString = '';
        Key = {};

        % Loop through each input and add encryption
        for i = 1:size(OriginalString, 2)
            % According to assignment, encrypt with up to 10 random separating characters
            SepLen = randi(10);

            % Populate string
            for Sep = 1:SepLen
                % Next index of string is random selection of alphanum pool
                EncryptedString(length(EncryptedString) + 1) = CharPool(randi(length(CharPool)));
            endfor

            % Next index of string is char from original string
            EncryptedString(length(EncryptedString) + 1) = OriginalString(i);
            % Store index for key
            Key{1, size(Key, 2) + 1} = length(EncryptedString);
        endfor

        % Re-populate end of string to prevent a the last char = last original char
        for Sep = 1:randi(10)
            EncryptedString(length(EncryptedString) + 1) = CharPool(randi(length(CharPool)));
        endfor

        % Assign the aliases to their respective outputs
        EncryptedOutput{1, iCell} = EncryptedString;
        EncryptedKeys{1, iCell} = Key;
    endfor


    % If data to encode was given as char, convert output to char & keys to vector matrix
    if strcmp(EncodeType, 'char')
        EncryptedOutput = EncryptedOutput{1, 1};
        EncryptedKeys = cell2mat(EncryptedKeys{1, 1});
    end

endfunction
