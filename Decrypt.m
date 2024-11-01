function[DecryptedCell] = Decrypt(EncryptedCell, Key)
DecryptedCell = {};
for i = 1:size(EncryptedCell, 2)
    DecryptedCell{1, i} = '';
    if size(Key, 2) == 0
        continue
    endif
    disp(size(Key, 1))
    for j = 1:size(Key, 2)
        DecryptedCell{1, i}(j) = EncryptedCell{1, i}(Key{1, i}{1, j})
        disp(DecryptedCell{1, i})
    endfor
    
    
endfor

endfunction