math.randomseed(2137)
gracz={type="fill",x=10,y=1,height=30,width=10,speed=5}
przeciwnik={type="fill",x=780,y=0,height=30,width=10,speed=5}
pilka={type="fill",x=400,y=300,radius=5,speed=5,xs=math.random(-10,10),ys=math.random(-10,10)}
punktygracza=0
punktyprzeciwnika=0
stan="stop"
function statusgry(stan)
    if stan=="stop" and love.keyboard.isDown("return") then 
        stan="gra"
    end
    if stan=="gra" and love.keyboard.isDown("return") then 
        stan="stop"
    end
    return stan
end
function ruchgracza(y,speed)
    if love.keyboard.isDown("w") and y>0 then 
        y=y-speed
    end 
    if love.keyboard.isDown("s") and y<600-speed then 
        y=y+speed
    end
    return y
end
function ruchprzeciwnika(y,speed,yp)
    if yp>y  then 
        y=y+speed
    end
    if yp<y then 
        y=y-speed
    end
    return y
end

function love.load()
end
function love.update()
    stan=statusgry(stan)
    ---ruch gracza
    gracz.y=ruchgracza(gracz.y,gracz.speed)
    ---ruch przeciwnika
    przeciwnik.y=ruchprzeciwnika(przeciwnik.y,przeciwnik.speed,pilka.y)
    ---ruch pilki
    if pilka.y<=0 or pilka.y>=600 then 
        pilka.ys=-1*pilka.ys
    end
    if pilka.x<0 or pilka.x>800 then 
        pilka.xs=-1*pilka.xs
        if pilka.x<gracz.x then 
            punktyprzeciwnika=punktyprzeciwnika+1
            pilka.x=400
            pilka.y=300
        end
        if pilka.x>przeciwnik.x then 
            punktygracza=punktygracza+1
            pilka.x=400
            pilka.y=300
        end
    end
    ---zderzenie pilki z graczem
    if pilka.x<=gracz.x+gracz.width and pilka.x>=gracz.x and pilka.y<=gracz.y+gracz.height and pilka.y>=gracz.y then 
        pilka.xs=-1*pilka.xs
        pilka.speed=pilka.speed+1
    end
    ---zderzenie pilki z przeciwnikiem 
    if pilka.x<=przeciwnik.x+przeciwnik.width and pilka.x>=przeciwnik.x and pilka.y<=przeciwnik.y+przeciwnik.height and pilka.y>=przeciwnik.y then 
        pilka.xs=-1*pilka.xs
        pilka.speed=pilka.speed+1

    end

 

    pilka.y=pilka.y+((pilka.ys/10)*pilka.speed)
    pilka.x=pilka.x+((pilka.xs/10)*pilka.speed)
 
    if punktygracza>punktyprzeciwnika+5 then 
        przeciwnik.speed=przeciwnik.speed+1
    end
    if punktyprzeciwnika>punktygracza+5 then 
        if przeciwnik.speed==5 then 
            przeciwnik.speed=przeciwnik.speed-1
        end
        if przeciwnik.speed>5 then 
            przeciwnik.speed=5
        end
    end
end
function love.draw()
    ---rysowanie gracza
    love.graphics.setColor(1,1,0)
    love.graphics.rectangle(gracz.type,gracz.x,gracz.y,gracz.width,gracz.height)
    ---rysowanie przeciwnika
    love.graphics.setColor(1,0,1)
    love.graphics.rectangle(przeciwnik.type,przeciwnik.x,przeciwnik.y,przeciwnik.width,przeciwnik.height)
    ---rysowanie pilki
    love.graphics.setColor(0,1,1)
    love.graphics.circle(pilka.type,pilka.x,pilka.y,pilka.radius)
    ---wypisywanie wyniku
    love.graphics.print(tostring(punktygracza),0,0)
    love.graphics.print(tostring(punktyprzeciwnika),770,0)
end