function [EncodedCell, RotationCell] = Encoder_TEAM(Cell)
    EncodedCell = {};
    RotationCell = {};

    for i = 1:size(Cell, 2)
        String = Cell{1, i};

        if length(String) == 0
            continue
        end

        EncodedCell{1, i} = '';
        RotationCell{1, i} = randi(25);

        for j = 1:length(String)
            ASCIICode = double(String(j));

            if ASCIICode >= 65 && ASCIICode <= 90% Uppercase
                ASCIIRotated = 65 + mod(ASCIICode + RotationCell{1, i} - 65, 26);
            elseif ASCIICode >= 97 && ASCIICode <= 122% Lowercase
                ASCIIRotated = 97 + mod(ASCIICode + RotationCell{1, i} - 97, 26);
            elseif ASCIICode >= 48 && ASCIICode <= 57% Numbers
                ASCIIRotated = 48 + mod(ASCIICode + RotationCell{1, i} - 48, 26);
            else
                ASCIIRotated = ASCIICode;
            endif

            EncodedCell{1, i}(j) = char(ASCIIRotated);

        end

    end

endfunction
