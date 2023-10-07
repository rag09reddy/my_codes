% Load the data from the first file
data1 = importdata('surfaceProfileTable_ring_19.txt');  % Replace with your actual filename
data1 = data1.data;  % Assuming numeric data is in the 'data' field

% Load the data from the second file
data2 = importdata('surfaceProfileTable_ring_16.txt');  % Replace with your actual filename
data2 = data2.data;  % Assuming numeric data is in the 'data' field

% Check if the sizes of data matrices are the same
if isequal(size(data1), size(data2))
    % Find indices where data is different
    diffIndices = data1 ~= data2;

    % Create a matrix with differences only
    combinedData = data1 .* diffIndices + data2 .* diffIndices;

    % Save the combined data to a new file with "micron:" at the start of each line
    fileID = fopen('combined_file.txt', 'w');  % Open the file for writing
    fprintf(fileID, 'micron:');  % Print "micron:" at the start
    fprintf(fileID, '\t%.16g', combinedData(1, :));  % Print the first row
    fprintf(fileID, '\n');  % Move to the next line

    for i = 2:size(combinedData, 1)
        fprintf(fileID, 'micron:');  % Print "micron:" at the start of each line
        fprintf(fileID, '\t%.16g', combinedData(i, :));  % Print the row
        fprintf(fileID, '\n');  % Move to the next line
    end

    fclose(fileID);  % Close the file
else
    disp('Data matrices have different sizes. Cannot combine.');
end
