-- 削除したいオブジェクトのモデル名と座標を指定
local objectsToDelete = {
    {model = "prop_sec_barrier_ld_01a", coords = vector3(206.5274, -803.4797, 30.95355)},
    {model = "prop_sec_barier_base_01", coords = vector3(206.5139, -803.2482, 29.9843)},

    {model = "prop_sec_barrier_ld_01a", coords = vector3(230.9218, -816.153, 30.16897)},
    {model = "prop_sec_barier_base_01", coords = vector3(230.9401, -816.4125, 29.30846)},

    -- 必要に応じて他のオブジェクトを追加
}

-- オブジェクトを削除する関数
local function deleteObject(model, coords)
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end

    local obj = GetClosestObjectOfType(coords.x, coords.y, coords.z, 1.0, hash, false, false, false)
    if DoesEntityExist(obj) then
        SetEntityAsMissionEntity(obj, true, true)
        DeleteObject(obj)
    end
end

-- オブジェクトを削除するスレッド
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for _, obj in ipairs(objectsToDelete) do
            deleteObject(obj.model, obj.coords)
        end
    end
end)
