math.randomseed(42069)
wynik=1
zycie=100
gracz={type="fill",x=400,y=300,radius=10,speed=5}
przeciwniki={}
pociski={}
zlepociski={}
counter=0
cmax=math.random(0,60)
stangry="stop"
function zmianastanu(stangry,zycie)
    if wynik>=1000 then 
        stangry="wygrales"
    end
    if stangry=="gra" and love.keyboard.isDown("escape") then 
        stangry="stop"
    end
    if stangry=="stop" and love.keyboard.isDown("return") then 
        stangry="gra"
    end
    if zycie<=0 then 
        stangry="koniec"
    end
    return stangry
end
--ruch postacia 
function ruch(x,y,speed)

        if love.keyboard.isDown("w") and y>0 then 
            y=y-speed
        end

        if love.keyboard.isDown("s") and y<600 then 
            y=y+speed
        end
        

        if love.keyboard.isDown("a") and x>0 then 
            x=x-speed
        end

        if love.keyboard.isDown("d") and x<800 then 
            x=x+speed
        end
    return x,y
end

function love.get()
end

function love.update()

    stangry=zmianastanu(stangry,zycie)
    if stangry=="gra" then 

    --tworzenie nowych przeciwnikow
    if counter>=cmax then
        table.insert(przeciwniki,{type="fill",x=math.random(0,800),y=-100,radius=10,speed=5})
        counter=0
        cmax=math.random(0,60)
    end
    --aktualizacja countera
    counter=counter+1
    --ruch bohaterem 
    gracz.x, gracz.y=ruch(gracz.x,gracz.y,gracz.speed)
    --aktualizacja stanu pociskow
    for i,v in ipairs(pociski) do
        v.y=v.y-v.speed 
        if v.y<gracz.y-500 then 
            table.remove(pociski,i)
        end
        for j,d in ipairs(przeciwniki) do
            if v.x<d.x+d.radius and v.x>d.x-d.radius and v.y<d.y+d.radius and v.y>d.y-d.radius then 
                table.remove(przeciwniki,j)
                table.remove(pociski,i)
                wynik=wynik+1            end 
        end
    end
    --aktualizacja stanu zlych pociskowv
    for i,v in ipairs(zlepociski) do
        if v.x<gracz.x+gracz.radius and v.x>gracz.x-gracz.radius then 
            zycie=zycie-1
            table.remove(zlepociski,i)
        end

        v.y=v.y+v.speed 
    end 
    --ruch przeciwnikow 
    for i,v in ipairs(przeciwniki) do
        --czy koliduje z graczem i czy mu zycie zabiera
        if v.x<gracz.x+gracz.radius and v.x>gracz.x-gracz.radius and v.y<gracz.y+gracz.radius and v.y>gracz.y-gracz.radius then 
            zycie=zycie-1
        end
        ---strzelanie wrogow
        if i==counter and math.random(1,10)%2==0 then 
            table.insert(zlepociski,{type="fill",x=v.x,y=v.y,radius=5,speed=5})
        end
        ---kasowanie wrogow
        if v.y-gracz.y>1000 then 
            table.remove(przeciwniki,i)
        end
        if gracz.x>v.x and gracz.y-v.y>100 then 
            v.x=v.x+v.speed
        end
        if gracz.x<v.x and gracz.y-v.y>100 then 
            v.x=v.x-v.speed
        end
        if gracz.y-v.y<100 then 
            v.x=v.x+math.random(-v.speed,v.speed)
        end
        v.y=v.y+v.speed
        
    end 
    --strzelanie
    if love.keyboard.isDown("space") then 
        table.insert(pociski,{type="fill",x=gracz.x,y=gracz.y,speed=25,radius=3})
    end
end 
end

function love.draw()
    love.graphics.print(tostring(wynik),50,0)
    love.graphics.print(tostring(zycie))
    --rysowanie gracza
    love.graphics.setColor(1,1,0)
    love.graphics.circle(gracz.type,gracz.x,gracz.y,gracz.radius)
    --rysowanie pociskow
    love.graphics.setColor(1,0,1)
    for i,v in ipairs(pociski) do
        love.graphics.circle(v.type,v.x,v.y,v.radius) 
    end
    --rysowanie przeciwnikow
    love.graphics.setColor(0,1,1)
    for i,v in ipairs(przeciwniki) do 
        love.graphics.circle(v.type,v.x,v.y,v.radius)
    end
    --rysowanie wrogich pociskow
    love.graphics.setColor(1,0,0)
    for i,v in ipairs(zlepociski)do
        love.graphics.circle(v.type,v.x,v.y,v.radius) 
    end
    if stangry=="koniec" then
        love.graphics.setColor(1,1,1) 
        love.graphics.print("koniec gry",400,300)
    end
    if stangry=="stop" then 
        love.graphics.setColor(1,1,1)
        love.graphics.print("pauza",400,300)
    end
    if stangry=="wygrales" then
        love.graphics.setColor(0,1,0) 
        love.graphics.print("gratulacje wygrales",400,300)
    end

end