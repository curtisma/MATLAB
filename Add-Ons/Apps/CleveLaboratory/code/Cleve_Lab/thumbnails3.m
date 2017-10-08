function farg = thumbnails3(f)
farg = [];
switch func2str(f)

% calculator
    case 'calculator'
        load labapp_pix
        if rand < .5
            f = calculator_pix1;
        else
            f = calculator_pix2;
        end
        [p,q,~] = size(f);
        n = max(p,q) + 40;
        x = zeros(n,n,'uint8') + uint8(255);
        x(fix((n-p)/2)+(1:p),fix((n-q)/2)+(1:q)) = f;
        showim(cat(3,x,x,x))
        
%--------------------------------------------------------------------
% roman_clock
    case 'roman_clock'
        load labapp_pix
        f = r_clock_pix;
        [p,q] = size(f);
        n = max(p,q) + 120;
        x = zeros(n,n,'uint8') + uint8(255);
        x(fix((n-p)/2)+(1:p),fix((n-q)/2)+(1:q)) = f;
        showim(cat(3,x,x,x))
               
%--------------------------------------------------------------------
% arrowhead
    case 'arrowhead'
        showim(imread('arrowhead_04.png'))
        
%--------------------------------------------------------------------
% lab1
    case 'lab1'
        showim(imread('lab_01.png'))
        axis square
        text(.5,.5,'lab1', ...
            'units','normalized', ...
            'horiz','center', ...
            'fontname','courier', ...
            'fontweight','bold', ...
            'fontsize',16)  
        
%--------------------------------------------------------------------
% lab3
    case 'lab3'
        showim(imread('lab_03.png'))
        axis square
        text(.5,.5,'lab3', ...
            'units','normalized', ...
            'horiz','center', ...
            'fontname','courier', ...
            'fontweight','bold', ...
            'fontsize',16)
       
%--------------------------------------------------------------------
% otherwise
    otherwise
end
