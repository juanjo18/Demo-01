function bordes()

    function [nueva] = R(matriz)
        [M,N] = size(matriz);
        nueva = zeros(M,N);
        
    
    function [Is] = dilatacion(I, B, k)
        [M,N] = size(I);
    
        Is = zeros(M,N);
        BR = R(B);

        for i=1+k:M-k
            for j=1+k:N-k
                sM = I(i-k:i+k, j-k:j+k);
                Is(i,j) = sum(sum(sM & BR));
            end
        end
        
        Is(Is > 1) = 1;
    end

    function [Is] = erosion(I, B, k)
        [m,n] = size(B)
        lenB = m*n
        BR = R(B);
        [M,N] = size(I);

        Is = zeros(M,N);

        for i=1+k:M-k
            for j=1+k:N-k
                sM = I(i-k:i+k, j-k:j+k);
                if(sum(sM(sM == BR)) == lenB)
                    Is(i,j) = I(i,j);
                else
                    Is(i,j) = 0;
                end
            end
        end
    end

    function [Is] = apertura(I, B, k)
        Is = erosion(I, B, k);
        Is = dilatacion(Is, B, k);
    end

    function [Is] = cierre(I, B, k)
        Is = dilatacion(I, B, k);
        Is = erosion(Is, B, k);
    end
    
    
    B  = [1 1 1; 1 1 1; 1 1 1];
    
    I = imread('circles.png');
    Iapertura = apertura(I, B, 1);
    Icierre = cierre(I, B, 1);
    Ierosion = erosion(I, B, 1);
    Ibordes = Iapertura - Ierosion;
    
    subplot(2,4,1);
    imshow(I);
    xlabel('Original ')
    subplot(2,4,2);
    imshow(Iapertura);
    xlabel('Apertura 3')
    subplot(2,4,3);
    imshow(Icierre);
    xlabel('Cierre 3')
    subplot(2,4,4);
    imshow(Ibordes);
    xlabel('Bordes 3')
    
    
    B  = [1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1; 1 1 1 1 1];
    
    I = imread('cameramn');
    Iapertura = apertura(I, B, 2);
    Icierre = cierre(I, B, 2);
    Ierosion = erosion(I, B, 2);
    Ibordes = Iapertura - Ierosion;
    
    subplot(2,4,5);
    imshow(I);
    xlabel('Original ')
    subplot(2,4,6);
    imshow(Iapertura);
    xlabel('Apertura 5')
    subplot(2,4,7);
    imshow(Icierre);
    xlabel('Cierre 5')
    subplot(2,4,8);
    imshow(Ibordes);
    xlabel('Bordes 5')

end
