function [decryptedCell] = Decoder_TEAM(encryptedCell, keyCell)
    decryptedCell = {};

    for i = 1:size(encryptedCell, 2)
        decryptedCell{1, i} = '';

        if size(encryptedCell, 2) == 0
            continue
        endif

        currRotation = keyCell{1, i};

        currString = encryptedCell{1, i};

        if length(currString) == 0
            continue
        end

        decryptedCell{1, i} = '';

        for j = 1:length(currString)
            asciiCode = double(currString(j));

            if asciiCode >= 65 && asciiCode <= 90 % Uppercase
                asciiRotated = 65 + mod(asciiCode - currRotation - 65, 26);
            elseif asciiCode >= 97 && asciiCode <= 122 % Lowercase
                asciiRotated = 97 + mod(asciiCode - currRotation - 97, 26);
            elseif asciiCode >= 48 && asciiCode <= 57 % Numbers
                asciiRotated = 48 + mod(asciiCode - currRotation - 48, 10);
            else
                asciiRotated = asciiCode;
            endif

            decryptedCell{1, i}(j) = char(asciiRotated);

        end

    endfor

endfunction
