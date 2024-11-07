function [EncodedCell, RotationCell] = Encoder_TEAM(Cell, CustomRotation)
    EncodeType = class(Cell);
    if strcmp(EncodeType, 'char')
        Cell = { Cell };
    end


    EncodedCell = {};
    RotationCell = {};

    for i = 1:size(Cell, 2)
        String = Cell{1, i};

        if length(String) == 0
            continue
        end

        EncodedCell{1, i} = '';
        if nargin == 2
            RotationCell(1, i) = CustomRotation
        else
            RotationCell{1, i} = randi(25);
        end

        for j = 1:length(String)
            ASCIICode = double(String(j));

            if ASCIICode >= 65 && ASCIICode <= 90% Uppercase
                ASCIIRotated = 65 + mod(ASCIICode + RotationCell{1, i} - 65, 26);
            elseif ASCIICode >= 97 && ASCIICode <= 122% Lowercase
                ASCIIRotated = 97 + mod(ASCIICode + RotationCell{1, i} - 97, 26);
            elseif ASCIICode >= 48 && ASCIICode <= 57% Numbers
                ASCIIRotated = 48 + mod(ASCIICode + RotationCell{1, i} - 48, 10);
            else
                ASCIIRotated = ASCIICode;
            end

            EncodedCell{1, i}(j) = char(ASCIIRotated);

        end

    end

    if strcmp(EncodeType, 'char')
        EncodedCell = EncodedCell{1, i};
    end
end
