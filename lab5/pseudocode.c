
int bitmap[128*128];
void get_coord(int input,int* x,int* y)
{
    *x=input>>16;
    *y=input&255;//0xFF
}
void clear_bitmap(int color)
{
    for(int i=0;i<128*128;i++)
    {
        bitmap[i]=color;
    }
}

void draw_pixel(int coord,int color)//0x00XX 00YY
{
    int index=0;//(0x0000YYXX);
    int x=coord>>16;
    int y=coord&255;
    index=(y*128+x);

    bitmap[index]=color;
}

int get_pixel(int coord)
{
    //$v0=bitmap[index];
    int index=0;//(0x0000YYXX);
    int x=coord>>16;
    int y=coord&255;
    index=(y*128+x);

    return bitmap[index];
}

void draw_solid_circle(int coord,int r,int color)
{
    int xc=coord>>16;
    int yc=coord&255;//0xFF
    int xmin = xc-r;
    int xmax = xc+r;
    int ymin = yc-r;
    int ymax = yc+r;
    for(int x=xmin;x<=xmax;x++)
    {
        for(int y=ymin;y<=ymax;y++)
        {
            int delta=(x-xc)*(x-xc)+(y-yc)*(y-yc);
            if(delta<r*r)
            {
                coord=x<<16;
                coord+=y;
                draw_pixel(coord,color);
            }
        }
    }
}

void draw_circle_pixels(int coord, int color, int x, int y) 
{
    int xpart=coord>>16;
    int ypart=coord&255;
    coord=((xpart+x)<<16)+(ypart+y);
    draw_pixel(coord,color);
    coord=((xpart-x)<<16)+(ypart+y);
    draw_pixel(coord,color);
    coord=((xpart+x)<<16)+(ypart-y);
    draw_pixel(coord,color);
    coord=((xpart-x)<<16)+(ypart-y);
    draw_pixel(coord,color);

    coord=((xpart+y)<<16)+(ypart+x);
    draw_pixel(coord,color);
    coord=((xpart-y)<<16)+(ypart+x);
    draw_pixel(coord,color);
    coord=((xpart+y)<<16)+(ypart-x);
    draw_pixel(coord,color);
    coord=((xpart-y)<<16)+(ypart-x);
    draw_pixel(coord,color);
} 

void draw_circle(int coord, int r, int color) 
{ 
    int xc=coord>>16;
    int yc=coord&255;
    int x = 0, y = r; 
    int d = 3 - 2 * r; 
    draw_circle_pixels((xc<<16)+yc,color, x, y); 
    while (y >= x) 
    { 
        // for each pixel we will 
        // draw all eight pixels 
          
        x++; 
  
        // check for decision parameter 
        // and correspondingly  
        // update d, x, y 
        if (d > 0) 
        { 
            y--;  
            d = d + 4 * (x - y) + 10; 
        } 
        else
            d = d + 4 * x + 6; 
        draw_circle_pixels((xc<<16)+yc,color, x, y);
    } 
} 

