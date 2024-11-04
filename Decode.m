function[DecryptedCell] = Decode(EncryptedCell, KeyCell)
DecryptedCell = {};
for i = 1:size(EncryptedCell, 2)
    DecryptedCell{1, i} = '';
    if size(EncryptedCell, 2) == 0
        continue
    endif
    Rotation = KeyCell{1, i};

      String = EncryptedCell{1, i};
      if length(String) == 0
        continue
      end
      DecryptedCell{1, i} = '';
      for j = 1:length(String)
        ASCIICode = double(String(j));
    
        if ASCIICode >= 65 && ASCIICode <= 90 % Uppercase
            ASCIIRotated = 65 + mod(ASCIICode - Rotation - 65, 26);
        elseif ASCIICode >= 97 && ASCIICode <= 122 % Lowercase
            ASCIIRotated = 97 + mod(ASCIICode - Rotation - 97, 26);
        elseif ASCIICode >= 48 && ASCIICode <= 57 % Numbers
            ASCIIRotated = 48 + mod(ASCIICode - Rotation - 48, 26);
        else
            ASCIIRotated = ASCIICode;
        endif
    
        DecryptedCell{1, i}(j) = char(ASCIIRotated);
    
      end
    
    
endfor

endfunction