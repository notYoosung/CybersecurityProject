function [DecryptedCell] = Decrypt_TEAM(EncryptedCell, Key)
    DecryptedCell = {};

    for i = 1:size(EncryptedCell, 2)
        DecryptedCell{1, i} = '';

        if size(Key, 2) == 0
            continue
        endif

        for j = 1:size(Key{1, i}, 2)
            DecryptedCell{1, i}(j) = EncryptedCell{1, i}(Key{1, i}{1, j});
        endfor

    endfor

endfunction
