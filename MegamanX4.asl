/*
	TITLE
	GAME START 選択
	キャラ選択 sceneSequence 0x0501
	ロード
	ムービー
	指令室
	ロード sceneSequence 0x000D
	OP1 0x0006
	ロード
	OP2
	イレギオン
	カーネル会話
	ロード
	MISSION COMPLETED
	ロード
	ムービー
	ロード
	指令室
*/

state("RXC1"){
	ushort sceneSequence: "RXC1.exe", 0x0179B114, 0x60;
	byte lifeupFlag: "RXC1.exe", 0x0179B114, 0x102;
	byte tankFlag: "RXC1.exe", 0x0179B114, 0x103;
	byte stageID: "RXC1.exe", 0x0179B114, 0xA4;
	byte stageSubID: "RXC1.exe", 0x0179B114, 0xA5;
	byte characterMovable: "RXC1.exe", 0x0179B114, 0xB4;
	byte spawnPointID: "RXC1.exe", 0x0179B114, 0xB5;
	float characterPointX: "RXC1.exe", 0x0179B114, 0x848;
	float characterPointY: "RXC1.exe", 0x0179B114, 0x850;
	byte characterHP: "RXC1.exe", 0x0179B114, 0x8B8;
	byte dashJumpStatus: "RXC1.exe", 0x0179B114, 0x910;
	byte enemyHP: "RXC1.exe", 0x0179B114, 0xE24;
}

init {
	vars.ROM = "";
	vars.isBossFighting = false;
	vars.sigmaSeq = 0;
}

startup {
	refreshRate = 60;

	vars.items = new List < Tuple < string, bool, string, string, string >>
	{
		Tuple.Create("Item", false, "Item", "", "Splits when you get Lifeup, Subtank, Weapontank and EX Item."),
		Tuple.Create("Lifeup", true, "Lifeup", "Item", "Splits when you get Lifeup."),
		Tuple.Create("Subtank", true, "Subtank", "Item", "Splits when you get Subtank."),
		Tuple.Create("Weapontank", true, "Weapontank", "Item", "Splits when you get Weapontank."),
		Tuple.Create("EXItem", true, "EX Item", "Item", "Splits when you get EX Item.")
	};
	foreach(var entry in vars.items) {
		if(entry.Item4 == ""){
			settings.Add(entry.Item1, entry.Item2, entry.Item3);
		} else {
			settings.Add(entry.Item1, entry.Item2, entry.Item3, entry.Item4);
		}
		settings.SetToolTip(entry.Item1, entry.Item5);
	}
}

start {
	if (old.sceneSequence != 0x0501 && current.sceneSequence == 0x0501) {
		vars.isBossFighting = false;
		vars.sigmaSeq = 0;
		print("MegamanX4 speedrun start");
		return true;
	}
}

reset {
}

split {
	// scene change
	{
		if (old.sceneSequence != 0x0006 && current.sceneSequence == 0x0006) {
			if (old.sceneSequence != 0x0206) {
				print("split: start playing");
				vars.isBossFighting = false;
				return true;
			}
		}
		if (old.sceneSequence != 0x000D && current.sceneSequence == 0x000D) {
			print("split: NOW LOADING stage");
			vars.isBossFighting = false;
			return true;
		}
		if (old.sceneSequence != 0x0007 && current.sceneSequence == 0x0007) {
			print("split: NOW LOADING weapon introduction");
			vars.isBossFighting = false;
			return true;
		}
		if (old.sceneSequence != 0x0103 && current.sceneSequence == 0x0103) {
			print("split: NOW LOADING stage select");
			vars.isBossFighting = false;
			return true;
		}
		if (old.sceneSequence != 0x0109 && current.sceneSequence == 0x0109) {
			print("split: MISSION COMPLETED");
			vars.isBossFighting = false;
			return true;
		}
	}

	// boss
	if(!vars.isBossFighting
	&& current.sceneSequence == 0x0006
	&& current.dashJumpStatus != 5
	) {
		// SKY LAGOON
		if(current.stageID == 0x00) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x02
			&& current.characterPointX > 4400.0
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle iregion");
				return true;
			}
		};
		// JUNGLE
		if(current.stageID == 0x01) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x05
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle web spider");
				return true;
			}
		}
		// SNOW BASE
		if(current.stageID == 0x02) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x03
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle frost walrus");
				return true;
			}
		}
		// BIO LABORATORY
		if(current.stageID == 0x03) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID >= 0x02
			&& current.characterPointY <= 460.0
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle split mashroom");
				return true;
			}
		}
		// VOLCANO
		if(current.stageID == 0x04) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x03
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle magma dragoon");
				return true;
			}
		}
		// MARINE BASE
		if(current.stageID == 0x05) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x01
			&& current.characterPointX > 17000
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle jet stingray");
				return true;
			}
		}
		// CYBER SPACE
		if(current.stageID == 0x06) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x01
			&& current.characterPointX > 960
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle cyber peacock");
				return true;
			}
		}
		// AIR FORCE
		if(current.stageID == 0x07) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x03
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle storm owl");
				return true;
			}
		}
		// MILITARY TRAIN
		if(current.stageID == 0x08) {
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x03
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle slash beast");
				return true;
			}
		}
		// SPACE PORT
		if(current.stageID == 0x0A) {
			if(current.stageSubID == 0x00
			&& current.spawnPointID == 0x02
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle colonel");
				return true;
			}
		}
		// FINAL WEAPON
		if(current.stageID == 0x0B) {
			if(current.stageSubID == 0x00
			&& current.spawnPointID == 0x01
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle double or iris");
				return true;
			}
			if(current.stageSubID == 0x01
			&& current.spawnPointID == 0x02
			&& current.characterMovable == 0x01
			){
				vars.isBossFighting = true;
				print("battle general");
				return true;
			}
		}
		// FINAL WEAPON
		if(current.stageID == 0x0C) {
			switch((int)vars.sigmaSeq){
				case 0:
					if(current.stageSubID == 0x01
					&& current.spawnPointID == 0x00
					&& current.characterPointX > 900.0
					&& current.characterMovable == 0x01
					){
						vars.sigmaSeq = 1;
						print("sigmaSeq: " + vars.sigmaSeq);
						return true;
					}
					break;
				case 1:
				case 2:
					if(old.enemyHP >= 1 && current.enemyHP == 0) {
						vars.sigmaSeq++;
						print("sigmaSeq: " + vars.sigmaSeq);
						return true;
					}
					break;
				case 3:
					if(old.enemyHP >= 1 && current.enemyHP == 0) {
						vars.sigmaSeq++;
						print("sigmaSeq: " + vars.sigmaSeq);
					}
					break;
				case 4:
					if(old.enemyHP >= 1 && current.enemyHP == 0) {
						vars.sigmaSeq++;
						print("sigmaSeq: " + vars.sigmaSeq);
						return true;
					}
					break;
				case 5:
					if(current.characterPointX >= 1761.0
					&& current.characterPointY >= 633.0
					) {
						vars.sigmaSeq++;
						print("sigmaSeq: " + vars.sigmaSeq);
						return true;
					}
					break;
			}
		}
	}

	// Item
	if(settings["Item"]) {
		// Lifeup
		if (settings["Lifeup"] && (old.lifeupFlag != current.lifeupFlag)) {
			return true;
		}
		// Subtank
		if (settings["Subtank"] && ((old.tankFlag & 0x30) != (current.tankFlag & 0x30))) {
			return true;
		}
		// Weapontank
		if (settings["Weapontank"] && ((old.tankFlag & 0x40) != (current.tankFlag & 0x40))) {
			return true;
		}
		// EXItem
		if (settings["EXItem"] && ((old.tankFlag & 0x80) != (current.tankFlag & 0x80))) {
			return true;
		}
	}
}

update {
	//RXC1
	vars.ROM = "RXC1";
	// print("sceneSequence : " + current.sceneSequence);
}
