//-----------------------------------------------------------------------------
//
// Copyright 2024-2025 Owlet VII
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/
//
//-----------------------------------------------------------------------------
//

class WadFusionStaticHandler : StaticEventHandler
{
	override void OnEngineInitialize()
	{
		if ( Wads.CheckNumForFullName('music/d_dm2ttl.mus') == -1 )
			S_ChangeMusic('d_intro', 0, false);
	}
	
	override void PostUiTick()
	{
		if ( CVar.FindCVar("wf_compat_changemusic").GetBool() )
		{
			DoSigilMusicReplacements(); // wf_mus_sigil.zs
			DoIdkfaMusicReplacements(); // wf_mus_idkfa.zs
			DoMusicReplacements();      // wf_mus_swap.zs
		}
	}
	
	override void ConsoleProcess(ConsoleEvent e)
	{
		// reset all custom cvars to their defaults
		if ( e.Name == "wf_reset2defaults" )
		{
			WadFusionReset2Defaults();
		}
	}
	
	ui void DoChangeMusic(string music)
	{
		// define array of supported title themes
		string titleMusic[] =
		{
			"d_intro",
			"d_introa",
			"s_intro",
			"s_introa",
			"s2_intro",
			"s2_intra",
			"d_dm2ttl",
			"t_dm2ttl",
			"p_dm2ttl",
			"x_dm2ttl",
			"h_dm2ttl",
			"h_intro"
		};
		
		// don't loop title themes
		for ( int i = 0; i < titleMusic.Size(); i++ )
		{
			DoSigilTitleMusicReplacements(); // wf_mus_sigil.zs
			DoIdkfaTitleMusicReplacements(); // wf_mus_idkfa.zs
			DoTitleMusicReplacements();      // wf_mus_swap.zs
			
			if ( music == titleMusic[i] )
				return;
			else if ( i == titleMusic.Size() - 1 )
				S_ChangeMusic(music);
		}
	}
}
