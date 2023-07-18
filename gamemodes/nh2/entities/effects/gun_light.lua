function EFFECT:Init( data )

	local vOffset = data:GetOrigin()
	local ent = data:GetEntity()

	local dlight = DynamicLight( ent:EntIndex() )

	if ( dlight ) then
		dlight.Pos = vOffset
		dlight.r = 255
		dlight.g = 150
		dlight.b = 0
		dlight.Brightness = 1
		dlight.Size = 396
		dlight.DieTime = CurTime() + 0.001
		dlight.Decay = 15
	end

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end