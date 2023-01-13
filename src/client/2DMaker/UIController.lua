--[[
    Author: StarShadow64/AtheriaRevolution
    Creation Date: 13/01/2023

    Description:
        No description provided.

    Documentation:
        No documentation provided.
--]]

--> Root <--

local UIController = { }

--> Roblox Services <--

--> Modules & Config <--

--> Constants <--

local player = game.Players.LocalPlayer
local UI = player.PlayerGui:FindFirstChild("ClientUI")
local PromptOC = UI:FindFirstChild("SingleInputFrame")
local PromptTC = UI:FindFirstChild("DoubleInputFrame")

--> Variables <--

local IsPromptShown = false
local ChoosenPrompt = nil

--> Functions <--

local function AnimatePrompt(prompt, val)
    local endTransparency
    if val == true then endTransparency = 0 else endTransparency = 1 end
    if prompt.Visible == false then
        prompt.BackgroundTransparency = 1
        for i, elements in pairs(prompt:GetChildren()) do
            if elements:IsA("Frame") then
                elements.BackgroundTransparency = 1
            elseif elements:IsA("TextLabel")then
                if elements.BackgroundTransparency ~= 1 then
                    elements:SetAttribute("Transp", elements.BackgroundTransparency)
                    elements.BackgroundTransparency = 1
                end
                elements.TextTransparency = 1
            elseif elements:IsA("TextBox") or elements:IsA("TextButton") then
                elements.BackgroundTransparency = 1
                elements.TextTransparency = 1
            end
        end
        prompt.Visible = true
    end

    local TF1 = game.TweenService:Create(prompt, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {BackgroundTransparency = endTransparency})
    TF1:Play()
    for i, elements in pairs(prompt:GetChildren()) do
        if elements:IsA("Frame") then
            local T1 = game.TweenService:Create(elements, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {BackgroundTransparency = endTransparency})
            T1:Play()
        elseif elements:IsA("TextLabel")then
            local T1 = game.TweenService:Create(elements, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {BackgroundTransparency = elements:GetAttribute("BackgroundTransparency")})
            local T2 = game.TweenService:Create(elements, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {TextTransparency = endTransparency})
            T1:Play()
            T2:Play()
        elseif elements:IsA("TextBox") or elements:IsA("TextButton") then
            local T1 = game.TweenService:Create(elements, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {BackgroundTransparency = endTransparency})
            local T2 = game.TweenService:Create(elements, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0), {TextTransparency = endTransparency})
            T1:Play()
            T2:Play()
        end
    end

    task.wait(0.25)
end

--> Job API <--

function UIController:CreateNewPrompt(PromptNM, PromptText, Input1T, Input2T)
    local FinalInput1, FinalInput2
    if IsPromptShown == false then
        IsPromptShown = true
        if Input2T then ChoosenPrompt = PromptTC else ChoosenPrompt = PromptOC end
        ChoosenPrompt.InputName.Text = PromptNM
        ChoosenPrompt.InputDescription.Text = PromptText
        if Input2T then
            ChoosenPrompt.Input1Box.PlaceholderText = Input1T
            ChoosenPrompt.Input2Box.PlaceholderText = Input2T
        else
            ChoosenPrompt.InputBox.PlaceholderText = Input1T
        end
    end

    AnimatePrompt(ChoosenPrompt, true)
    local Activated = false
    ChoosenPrompt.EnterButton.MouseButton1Click:Connect(function()
        if Input2T then
            if #ChoosenPrompt.Input1Box.Text > 0 and #ChoosenPrompt.Input2Box.Text > 0 and Activated == false then
                FinalInput1 = ChoosenPrompt.Input1Box.Text
                FinalInput2 = ChoosenPrompt.Input2Box.Text
                Activated = true
            else
                ChoosenPrompt.EnterButton.Text = "Incorrect Inputs"
            end
        else
            if #ChoosenPrompt.InputBox.Text > 0 and Activated == false then
                FinalInput1 = ChoosenPrompt.InputBox.Text
                Activated = true
            else
                ChoosenPrompt.EnterButton.Text = "Incorrect Inputs"
            end
        end
    end)

    repeat task.wait() until Activated == true

    AnimatePrompt(ChoosenPrompt, false)
    return FinalInput1, FinalInput2
end

return UIController