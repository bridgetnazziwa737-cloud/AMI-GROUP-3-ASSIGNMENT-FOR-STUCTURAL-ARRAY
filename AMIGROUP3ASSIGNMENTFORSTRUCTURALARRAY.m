% Group Assignment: structural array of different leaves

Leaves = struct('ScientificName', {}, 'CommonName', {}, 'Shape', {}, 'Margin', {}, 'Venation', {}, 'Image', {}, 'ProcessedImage', {});

Leaves(1).ScientificName = 'Ficus benghalensis';
Leaves(1).CommonName = 'Bayan';
Leaves(1).Shape = 'Ovate';
Leaves(1).Margin = 'Entire';
Leaves(1).Venation = 'Pinnate Reticulate';
Leaves(1).Image = 'C:\Users\DELL\Desktop\Bayan\Bayan.jpg';

Leaves(2).ScientificName = 'Senna siamea';
Leaves(2).CommonName = 'Kassod Tree';
Leaves(2).Shape = 'Elliptic to Lanceolate';
Leaves(2).Margin = 'Entire';
Leaves(2).Venation = 'Pinnate Reticulate';
Leaves(2).Image = 'C:\Users\DELL\Desktop\Kassod Tree\Kassod Tree.jpg';

Leaves(3).ScientificName = 'Ficus benjamina';
Leaves(3).CommonName = 'Weeping Fig';
Leaves(3).Shape = 'Lanceolate to Elliptic';
Leaves(3).Margin = 'Entire';
Leaves(3).Venation = 'Pinnate Reticulate';
Leaves(3).Image = 'C:\Users\DELL\Desktop\Weeping Fig\Weeping Fig.jpg';

Leaves(4).ScientificName = 'Polyalthia longifolia';
Leaves(4).CommonName = 'False Ashoka';
Leaves(4).Shape = 'Long Lanceolate';
Leaves(4).Margin = 'Entire';
Leaves(4).Venation = 'Pinnate Reticulate';
Leaves(4).Image = 'C:\Users\DELL\Desktop\False Ashoka\False Ashoka.jpg';

Leaves(5).ScientificName = 'Ficus benjamina';
Leaves(5).CommonName = 'Weeping Fig';
Leaves(5).Shape = 'Elliptic-Lanceolate';
Leaves(5).Margin = 'Entire';
Leaves(5).Venation = 'Pinnate Reticulate';
Leaves(5).Image = 'C:\Users\DELL\Desktop\Weeping fig 2\Weeping Fig.jpg';

Leaves(6).ScientificName = 'Zea mays';
Leaves(6).CommonName = 'Maize';
Leaves(6).Shape = 'Linear-Lanceolate';
Leaves(6).Margin = 'Entire';
Leaves(6).Venation = 'Parallel';
Leaves(6).Image = 'C:\Users\DELL\Desktop\Maize\Maize.jpg';

Leaves(7).ScientificName = 'Persea americana';
Leaves(7).CommonName = 'Ovacado';
Leaves(7).Shape = 'Elliptic-Lanceolate';
Leaves(7).Margin = 'Entire';
Leaves(7).Venation = 'Pinnate Reticulate';
Leaves(7).Image = 'C:\Users\DELL\Desktop\Ovacado\Ovacado.jpg';

Leaves(8).ScientificName = 'Artocarpus heterophyllus';
Leaves(8).CommonName = 'Jackfruit';
Leaves(8).Shape = 'Ovate-Elliptic';
Leaves(8).Margin = 'Entire';
Leaves(8).Venation = 'Pinnate Reticulate';
Leaves(8).Image = 'C:\Users\DELL\Desktop\Jackfruit\Jackfruit.jpg';

Leaves(9).ScientificName = 'carica papaya';
Leaves(9).CommonName = 'Papaya';
Leaves(9).Shape = 'Palmately Lobed';
Leaves(9).Margin = 'Deeply Lobed';
Leaves(9).Venation = 'Pinnate Reticulate';
Leaves(9).Image = 'C:\Users\DELL\Desktop\Papaya\Papaya.jpg';

Leaves(10).ScientificName = 'Psidium guajava';
Leaves(10).CommonName = 'Guava';
Leaves(10).Shape = 'Elliptic-Oblong';
Leaves(10).Margin = 'Entire';
Leaves(10).Venation = 'Pinnate Reticulate';
Leaves(10).Image = 'C:\Users\DELL\Desktop\Guava\Guava.jpg';

for i = 1:10
    rgbImg = imread(Leaves(i).Image);
    grayImg = rgb2gray(rgbImg);
    
    bwMask = ~imbinarize(grayImg); 
    bwMask = imfill(bwMask, 'holes');
    bwMask = bwareaopen(bwMask, 50);
    
    Leaves(i).ProcessedImage = bwMask;
    
    geometry = regionprops(bwMask, 'Area', 'Perimeter', 'Eccentricity', 'Solidity');
    
    [~, mainObject] = max([geometry.Area]); 
    
    Leaves(i).AreaInPixels = round(geometry(mainObject).Area);
    Leaves(i).Perimeter    = round(geometry(mainObject).Perimeter);
    Leaves(i).Eccentricity = round(geometry(mainObject).Eccentricity, 3);
    Leaves(i).Solidity     = round(geometry(mainObject).Solidity, 3);
    
    figure('NumberTitle', 'off', 'Name', ['Leaf ', num2str(i), ': ', Leaves(i).CommonName]);
    
    subplot(1, 2, 1); 
    imshow(rgbImg); 
    title('Original Image');
    
    subplot(1, 2, 2); 
    imshow(Leaves(i).ProcessedImage); 
    title('Processed Mask');
    
    drawnow; 
end

fprintf('\n--- Leaf Structural Array Summary ---\n\n');
tableDisplay = rmfield(Leaves, 'ProcessedImage');
disp(struct2table(tableDisplay));

          