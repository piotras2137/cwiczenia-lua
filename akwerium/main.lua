math.randomseed(420069)
ryby={}
pokarm={}
licznik=0
ls=0
---losowanie poczatkowego polozenia ryb
for i=0,256,1 do 
    table.insert(ryby,{x=math.random(0,800),y=math.random(0,600),radius=math.random(1,5),type=i%2,speed=1})
end
---losowanie poczatkowego polozenia pokarmu
for i=0,1024,1 do 
    table.insert(pokarm,{x=math.random(0,800),y=math.random(0,600),radius=1})
end
function love.get()
end
function love.update()
    for i,v in ipairs(ryby) do 
        if v.type==0 then 
            if v.radius<10 then
                for j,d in ipairs(pokarm) do 
                    if v.x==d.x and v.y==d.y then
                        v.radius=v.radius+2
                    end
                    
                    if v.x-d.x>-v.radius*10 and v.x-d.x<v.radius*10 and v.y-d.y>-v.radius*10 and v.y-d.y<v.radius*10 and v.radius>d.radius then 
                        if v.x<d.x then 
                            v.x=v.x+v.speed
                        end
                        if v.x>d.x then 
                            v.x=v.x-v.speed
                        end
                        if v.y<d.y then 
                            v.y=v.y+v.speed
                        end
                        if v.y>d.y then
                            v.y=v.y-v.speed
                        end
                        break
                    end

                end
            end
            if v.radius>1 then 
                for j,d in ipairs(ryby) do 
                    if v.radius>d.radius and v.x-v.radius<d.x and v.x+v.radius>d.x and v.y-v.radius<d.y and v.y+v.radius>d.y then 
                        d.radius=0
                        v.radius=v.radius+2
                    end
                end
                for j,d in ipairs(ryby) do 
                    if v.x-d.x>-v.radius*10 and v.x-d.x<v.radius*10 and v.y-d.y>-v.radius*10 and v.y-d.y<v.radius*10 and v.radius>d.radius then 
                        if v.x<d.x then 
                            v.x=v.x+v.speed
                        end
                        if v.x>d.x then 
                            v.x=v.x-v.speed
                        end
                        if v.y<d.y then 
                            v.y=v.y+v.speed
                        end
                        if v.y>d.y then
                            v.y=v.y-v.speed
                        end
                        break
                    end
                end
            end
        end 
        if v.type==1 then 
            ---jedzenie planktonu
            for j,d in ipairs(pokarm) do 
                if v.x-v.radius<d.x and v.x+v.radius>d.x and v.y-v.radius<d.y and v.y+v.radius>d.y then
                    v.radius=v.radius+1
                    table.remove(pokarm,j)
                end
            end
            for j,d in ipairs(pokarm) do 
                if v.x-d.x>-v.radius*10 and v.x-d.x<v.radius*10 and v.y-d.y>-v.radius*10 and v.y-d.y<v.radius*10 then 
                    if v.x<d.x then 
                        v.x=v.x+v.speed
                    end
                    if v.x>d.x then 
                        v.x=v.x-v.speed
                    end
                    if v.y<d.y then 
                        v.y=v.y+v.speed
                    end
                    if v.y>d.y then
                        v.y=v.y-v.speed
                    end
                break
                end
            end
        end
    end
    if licznik==30 then 
        for i,v in ipairs(ryby) do 
            for j,d in ipairs(ryby) do
                if ls%2==0 then 
                    if v.x<d.x and v.y<d.y then 
                        help=v
                        v=d
                        d=help
                    end 
                else
                    if v.x>d.x and v.y>d.y then 
                        help=d
                        d=v
                        v=help
                    end
                end
            end
        end
        licznik=0
        ls=ls+1
    end
    licznik=licznik+1
    for i,v in ipairs(ryby) do 
        if v.radius==0 then 
            table.remove(ryby,i)
        end
        if v.radius>100 then 
            for i=0,100,1 do 
                table.insert(pokarm,{x=math.random(v.x-v.radius,v.x+v.radius),y=math.random(v.y-v.radius,v.y+v.radius),radius=1})
            end
            table.remove(ryby,i)
        end
    end
    if math.random(1,10)%3==0 then
        table.insert(ryby,{x=math.random(0,800),y=math.random(0,600),radius=math.random(1,5),type=math.random(1,10)%2,speed=1})
    end
    if math.random(1,10)%2==0 then 
        table.insert(pokarm,{x=math.random(0,800),y=math.random(0,600),radius=1})
    end
    for i,v in ipairs(ryby) do 
        v.speed=1-(v.radius/100)
    end
end

function love.draw()
    ---ustawienie tla
    love.graphics.setBackgroundColor(0,0,1)
    ---rysowanie ryb
    for i,v in ipairs(ryby) do 
        ---kolor agresywnych ustawiony na czerwony
        if v.type==1 then
            love.graphics.setColor(1,1,0)
        ---kolor tych drugich ustawiony na taki inny
        else
            love.graphics.setColor(1,0,0)
        end
        love.graphics.circle("fill",v.x,v.y,v.radius)
    end
    ---rysowanie pokarmu
    love.graphics.setColor(0,1,1)
    for i,v in ipairs(pokarm) do
        love.graphics.circle("fill",v.x,v.y,v.radius)
    end
end
