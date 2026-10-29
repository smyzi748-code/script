local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PrankGui"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
background.BorderSizePixel = 0
background.Parent = screenGui

local firstLabel = Instance.new("TextLabel")
firstLabel.Size = UDim2.new(0.8, 0, 0.3, 0)
firstLabel.Position = UDim2.new(0.1, 0, 0.3, 0)
firstLabel.Text = "ВНИМАНИЕ!\nНажмите кнопку чтобы активировать скрипт"
firstLabel.TextScaled = true
firstLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
firstLabel.Font = Enum.Font.SourceSansBold
firstLabel.BackgroundTransparency = 1
firstLabel.Parent = background

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.3, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.35, 0, 0.65, 0)
closeButton.Text = "Активировать"
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.Parent = background

closeButton.MouseButton1Click:Connect(function()
    firstLabel:Destroy()
    closeButton:Destroy()

    -- 1. Таймер (ТЕПЕРЬ ВЕРХУ)
    local timerLabel = Instance.new("TextLabel")
    timerLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
    timerLabel.Position = UDim2.new(0.1, 0, 0.2, 0) -- Верхняя позиция
    timerLabel.TextScaled = true
    timerLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    timerLabel.Font = Enum.Font.SourceSansBold
    timerLabel.BackgroundTransparency = 1
    timerLabel.Parent = background

    -- 2. Меняющаяся надпись (ТЕПЕРЬ ВНИЗУ)
    local extraLabel = Instance.new("TextLabel")
    extraLabel.Size = UDim2.new(0.8, 0, 0.2, 0)
    extraLabel.Position = UDim2.new(0.1, 0, 0.5, 0) -- Ниже таймера
    extraLabel.Text = ""
    extraLabel.TextScaled = true
    extraLabel.TextColor3 = Color3.fromRGB(255, 150, 50)
    extraLabel.Font = Enum.Font.SourceSansBold
    extraLabel.BackgroundTransparency = 1
    extraLabel.Parent = background

    -- Создаем элемент звука напряженности/тревоги
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9114223177" -- Звук эмбиента/напряжения
    sound.Volume = 0.5
    sound.Looped = true
    sound.Parent = background
    sound:Play()

    task.spawn(function()
        local totalSeconds = 60

        while totalSeconds > 0 do
            local minutes = math.floor(totalSeconds / 60)
            local seconds = totalSeconds % 60
            timerLabel.Text = string.format("Осталось времени: %02d:%02d", minutes, seconds)

            -- Меняем тональность и громкость звука, чтобы он казался страшнее с каждой секундой
            sound.PlaybackSpeed = 1 + ((60 - totalSeconds) / 60) * 0.5
            sound.Volume = 0.5 + ((60 - totalSeconds) / 60) * 0.5

            -- Смена текстов снизу:
            if totalSeconds == 50 then
                extraLabel.Text = "Что-то сломалось ожидайте"
            elseif totalSeconds == 40 then
                extraLabel.Text = "баг убирается..."
            elseif totalSeconds == 30 then
                extraLabel.Text = "Процесс запущен на половину..."
            elseif totalSeconds == 20 then
                extraLabel.Text = "скрипт успешно активирован!"
            elseif totalSeconds == 10 then
                extraLabel.Text = "НИКАГО СКРИПТА НЕТУ МЫ ВЗЛОМАЛИ ТВОИ ДАННЫЕ ДАНИЯР ЖАКУПОВ"
                extraLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            end

            task.wait(1)
            totalSeconds = totalSeconds - 1
        end

        -- Останавливаем фоновый звук тревоги
        sound:Stop()

        -- Воспроизводим финальный звук пранка
        local prankSound = Instance.new("Sound")
        prankSound.SoundId = "rbxassetid://9069609268" -- Веселый/розыгрышный звук
        prankSound.Volume = 1
        prankSound.Parent = background
        prankSound:Play()

        -- Финальный экран
        extraLabel:Destroy()
        timerLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
        timerLabel.Text = "МЫ НАШЛИ ТВОИ ДАННЫЕ"
        timerLabel.TextColor3 = Color3.fromRGB(50, 255, 50)

        -- Оставляем меню висеть на 3 минуты (180 секунд)
        task.wait(180)
        screenGui:Destroy()
    end)
end)
