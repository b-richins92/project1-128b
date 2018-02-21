%Reticular Cell Method: Finding the Lower bound of L.
 
%Can either use lines 5-8 to input image, or input a matrix M, whose
%entries are either 1 or 0.
% M=imread('unitsphere.jpg');     %first we read the image then we code it
                                   % to grayscale, then black and white.
% M=rgb2gray(M);
% M=M>190;


M= eye(200);
maxDim = length(M);
newDim = 2^ceil(log2(maxDim));

rowP = newDim - size(M,1);
colP = newDim - size(M,2);

M = padarray(M, [rowP, colP], 'post');
[A, ~] = size(M);

mult = [2 4 8 16 32 64 128 256 512 1024]; %Can take on matrixes up with sides up to 1024 bits
D = zeros(length(mult), 1);
L_count = zeros(length(mult), 1);
L_size = zeros(length(mult), 1);

for i = 1:length(mult)
    L = A/mult(i);
    r = L/A;
    s=L*ones(1,mult(i));
    L_Boxes = mat2cell(M,[s],[s]); %Here we split matrix into L by L boxes
    
    [n, ~] = size(L_Boxes);
    L_size(i) = L;
    for j = 1:n
        for k = 1:n
            if (sum(sum(L_Boxes{j,k})) > 0)
                L_count(i) = L_count(i) + 1;
            end
        end
    end
    
    D(i) = log(L_count(i))/log(1/r); %Calculates D
end

D1 = -mean(diff(log(L_count)')./diff(log(A./mult))); %Average slope