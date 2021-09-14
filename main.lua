TELA_LARG = 420
TELA_ALT = 320
MAX_INIMIGOS = 20

Fred = {
    img = love.graphics.newImage("assets/fred-11.png"),
    alt = 60,
    larg = 41,
    x = TELA_LARG/2 -70, 
    y = TELA_ALT+41,

}

Inimigo = {
    img = "assets/flamengo.png",
    alt = 27,
    larg = 25,
    x = 0,
    y = 0,
} 

inimigos = {}

function Colidir( ... )
    for i,inimigo in ipairs(inimigos) do
        if inimigo.x < Fred.x + Fred.larg and Fred.x < inimigo.x + inimigo.larg and inimigo.y < Fred.y + Fred.alt and Fred.y < inimigo.y + inimigo.alt then
            love.event.quit('restart')
        end
    end
end

function Limpar_Inimigos()
    for i = #inimigos,1, -1 do
        if inimigos[i].y > TELA_ALT + 110 then
            table.remove(inimigos,i)
        end
    end
end

function Criar_Inimigo()
    Inimigo = {
        img = love.graphics.newImage("assets/flamengo.png"),
        alt = 33,
        larg = 25,
        x = math.random(TELA_LARG) -40,
        y = -40,
        pesoX = math.random(-1,1),
        pesoY = math.random(2,4)
    }
    table.insert(inimigos,Inimigo)
end 

function Move()
    if love.keyboard.isDown('w') and Fred.y - 1 > 0 then
        Fred.y = Fred.y - 1
    end
    if love.keyboard.isDown('s') and Fred.y + 1 < TELA_ALT + 40 then
        Fred.y = Fred.y + 1
    end
    if love.keyboard.isDown('a') and Fred.x - 1 > 0 then
        Fred.x = Fred.x - 1
    end
    if love.keyboard.isDown('d') and Fred.x + 1 < TELA_LARG - 140 then
        Fred.x = Fred.x + 1
    end

end

function Move_Meteoros()
    for k,inimigo in ipairs(inimigos) do
        inimigo.y = inimigo.y + inimigo.pesoY
        inimigo.x = inimigo.x + inimigo.pesoX
    end
    
end

function love.load()
    math.randomseed(os.time())
    love.window.setMode(TELA_ALT,TELA_LARG, {resizable = false})
    love.window.setTitle("Fred contra os anti")

    Bg = love.graphics.newImage("assets/campo_de_futebol.png")
end

function love.update(dt)
    if love.keyboard.isDown('w','a','s','d') then
        Move()
    end
    Limpar_Inimigos()
    if #inimigos < MAX_INIMIGOS then
        Criar_Inimigo()
    end
    Move_Meteoros()
    Colidir()
end

function love.draw()   
    love.graphics.draw(Bg, 0,0)
    for k,inimigo in ipairs(inimigos) do
        love.graphics.draw(inimigo.img, inimigo.x,inimigo.y)
    end
    love.graphics.draw(Fred.img, Fred.x,Fred.y)
end