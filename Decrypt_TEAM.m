function [decryptedCell] = Decrypt_TEAM(encryptedCell, key)
    decryptedCell = {};

    for i = 1:size(encryptedCell, 2)
        decryptedCell{1, i} = '';

        if size(key, 2) == 0
            continue
        endif

        for j = 1:size(key{1, i}, 2)
            decryptedCell{1, i}(j) = encryptedCell{1, i}(key{1, i}{1, j});
        endfor

    endfor

endfunction
