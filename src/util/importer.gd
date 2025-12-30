extends Node

var anim_importer: Importer= preload('uid://meajasg2uo4i').new()

var undead_creatures := {
	'Ghost': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Ghost/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Ghost/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Ghost/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Ghost/Idle_Fly.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Ghost/Idle_Fly.png',
			'time': 200
		}
	],
	'Headless_Skeleton': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Headless_Skeleton/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Headless_Skeleton/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Headless_Skeleton/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Headless_Skeleton/Idle_Activate_Deactivate.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Headless_Skeleton/Walk.png',
			'time': 200,
		}
	],
	'Jumping_Skull': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Jumping_Skull/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Jumping_Skull/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Jumping_Skull/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Jumping_Skull/Idle.png',
			'time': 100
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Jumping_Skull/Jump.png',
			'time': 200
		}
	],
	'Reanimated_Skeleton_Archer': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Archer/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Archer/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Archer/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Archer/Idle_Activation_Deactivation.png',
			'time': 200
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Archer/Walk.png',
			'time': 200
		}
	],
	'Reanimated_Skeleton_Mage': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Mage/Cast.png',
			'time': 200,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Mage/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Mage/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Mage/Idle_Activation_Deactivation.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Mage/Walk.png',
			'time': 200,
		}
	],
	'Reanimated_Skeleton_Warrior': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Warrior/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Warrior/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Warrior/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Warrior/Idle_Activation_Deactivation.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Skeleton_Warrior/Walk.png',
			'time': 200,
		}
	],
	'Reanimated_Zombie_Archer': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Archer/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Archer/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Archer/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Archer/Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Archer/Walk.png',
			'time': 200
		}
	],
	'Reanimated_Zombie_Mage': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Mage/Cast.png',
			'time': 200,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Mage/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Mage/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Mage/Idle.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Mage/Walk.png',
			'time': 200,
		}
	],
	'Reanimated_Zombie_Warrior': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Warrior/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Warrior/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Warrior/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Warrior/Idle.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Reanimated_Zombie_Warrior/Walk.png',
			'time': 200,
		}
	],
	'Skeletal_Horse': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Attack_horse.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Die_horse.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Dmg_horse.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Idle_Activation_Deactivation_horse.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Walk_horse.png',
			'time': 200
		}
	],
	'Skeletal_Horse_Rider': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Rider/Attack_rider.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Rider/Die_raider.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Rider/Dmg_raider.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Rider/Idle_Activation_Deactivation_raider.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeletal_Horse/Rider/Walk_raider.png',
			'time': 200,
		}
	],
	'Skeleton_Minotaur': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeleton_Minotaur/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeleton_Minotaur/Die.png',
			'time': 100,
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeleton_Minotaur/Dmg_layer 1.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeleton_Minotaur/Idle_activate_deactivate.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Skeleton_Minotaur/Walk_layer 2.png',
			'time': 200,
		}
	],
	'Zombie_Bear': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Bear/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Bear/Die.png',
			'time': 100,
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Bear/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Bear/Idle.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Bear/Walk.png',
			'time': 200,
		}
	],
	'Zombie_Giant': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Giant/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Giant/Die.png',
			'time': 100,
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Giant/Dmg.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Giant/Idle.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Giant/Walk.png',
			'time': 200,
		}
	],
	'Zombie_Minotaur': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Minotaur/Attack.png',
			'time': 100,
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Minotaur/Die.png',
			'time': 100,
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Minotaur/Dmg_flattened.png',
			'time': 100,
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Minotaur/Idle.png',
			'time': 200,
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Undead_Creatures_v1.0/Minifantasy_Undead_Creatures_Assets/Zombie_Minotaur/Walk.png',
			'time': 200,
		}
	]
}

# missing humanoids sub-folder
var creatures := {
	'Bat': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Bat/BatAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Bat/BatDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Bat/BatDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Bat/BatFlyIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Bat/BatFlyIdle.png',
			'time': 200
		},
		{
			'name': 'sleep',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Bat/BatSleep.png',
			'time': 100
		}
	],
	'Warg': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Warg/WargAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Warg/WargDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Warg/WargDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Warg/WargIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Warg/WargJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Warg/WargWalk.png',
			'time': 200
		}
	],
	'Wolf': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Wolf/WolfAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Wolf/WolfDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Wolf/WolfDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Wolf/WolfIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Wolf/WolfJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Beasts/Wolf/WolfWalk.png',
			'time': 200
		}
	],
	'Centaur': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Centaur/CentaurAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Centaur/CentaurDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Centaur/CentaurDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Centaur/CentaurIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Centaur/CentaurJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Centaur/CentaurWalk.png',
			'time': 200
		}
	],
	'Cyclop': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Cyclop/CyclopAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Cyclop/CyclopDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Cyclop/CyclopDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Cyclop/CyclopIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Cyclop/CyclopJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Cyclop/CyclopWalk.png',
			'time': 200
		}
	],
	'Evil_Snowman': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Evil_Snowman/EvilSnowmanAttack.png',
			'time': 100
		},
		{
			'name': 'spot',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Evil_Snowman/EvilSnowmanActivation.png',
			'time': 100
		},
	],
	'Minotaur': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Minotaur/MinotaurAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Minotaur/MinotaurDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Minotaur/MinotaurDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Minotaur/MinotaurIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Minotaur/MinotaurJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Minotaur/MinotaurWalk.png',
			'time': 200
		}
	],
	'Pumpkin_Horror': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Pumpkin_Horror/PumpkinHorrorBaseAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Pumpkin_Horror/PumpkinHorrorBaseDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Pumpkin_Horror/PumpkinHorrorBaseDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Pumpkin_Horror/PumpkinHorrorBaseIdleActivation.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Pumpkin_Horror/PumpkinHorrorBaseWalk.png',
			'time': 200
		}
	],
	'Trasgo': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoAttack.png',
			'time': 100
		},
		{
			'name': 'attack2',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoChargedAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoSpinDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Trasgo/TrasgoWalk.png',
			'time': 200
		}
	],
	'Troll': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Troll/TrollAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Troll/TrollDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Troll/TrollDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Troll/TrollIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Troll/TrollJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Troll/TrollWalk.png',
			'time': 200
		}
	],
	'Yeti': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Yeti/YetiAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Yeti/YetiDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Yeti/YetiDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Yeti/YetiIdle.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Yeti/YetiJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Monsters/Yeti/YetiWalk.png',
			'time': 200
		}
	],
	'Blue_Slime': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue _Slime/BlueSlimeDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue _Slime/BlueSlimeDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue _Slime/BlueSlimeIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue _Slime/BlueSlimeJumpAttack.png',
			'time': 200
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue _Slime/BlueSlimeJumpAttack.png',
			'time': 200
		}
	],
	'Blue_Mother_Slime': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue_Mother_Slime/BlueMotherSlimeDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue_Mother_Slime/BlueMotherSlimeDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue_Mother_Slime/BlueMotherSlimeIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue_Mother_Slime/BlueMotherSlimeJumpAttack.png',
			'time': 200
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Blue_Mother_Slime/BlueMotherSlimeJumpAttack.png',
			'time': 200
		}
	],
	'Green_Mother_Slime': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Mother_Slime/MotherSlimeGreenDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Mother_Slime/MotherSlimeGreenDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Mother_Slime/MotherSlimeGreenIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Mother_Slime/MotherSlimeGreenJumpAttack.png',
			'time': 200
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Mother_Slime/MotherSlimeGreenJumpAttack.png',
			'time': 200
		}
	],
	'Green_Slime': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Slime/SlimeGreenDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Slime/SlimeGreenDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Slime/SlimeGreenIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Slime/SlimeGreenJumpAttack.png',
			'time': 200
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Slimes/Green_Slime/SlimeGreenJumpAttack.png',
			'time': 200
		}
	],
	'Skeleton': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Skeleton/SkeletonAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Skeleton/SkeletonDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Skeleton/SkeletonDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Skeleton/SkeletonIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Skeleton/SkeletonWalk.png',
			'time': 200
		}
	],
	'Wildfire': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Wildfire/WildfireDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Wildfire/WildfireDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Wildfire/WildfireIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Wildfire/WildfireFly.png',
			'time': 200
		}
	],
	'Zombie': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Zombie/ZombieAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Zombie/ZombieDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Zombie/ZombieDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Zombie/ZombieIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Creatures_v3.2_Commercial_Version/Minifantasy_Creatures_Assets/Undead/Zombie/ZombieWalk.png',
			'time': 200
		}
	]
}

var wildlife_aggressive := {
	'Hyena': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Hyena/HyenaAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Hyena/HyenaDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Hyena/HyenaDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Hyena/HyenaIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Hyena/HyenaWalk.png',
			'time': 100
		},
	],
	'Lion': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lion/LionAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lion/LionDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lion/LionDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lion/LionIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lion/LionWalk.png',
			'time': 100
		},
	],
	'Lioness': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lioness/LionessAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lioness/LionessDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lioness/LionessDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lioness/LionessIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Lioness/LionessWalk.png',
			'time': 100
		},
	],
	'Polar_Bear': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Polar Bear/PolarBearAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Polar Bear/PolarBearDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Polar Bear/PolarBearDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Polar Bear/PolarBearIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Polar Bear/PolarBearWalk.png',
			'time': 100
		},
	],
	'Rhino': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Rhino/RhinoAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Rhino/RhinoDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Rhino/RhinoDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Rhino/RhinoIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Rhino/RhinoWalk.png',
			'time': 100
		},
	],
	'Snake': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Snake/SnakeAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Snake/SnakeDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Snake/SnakeDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Snake/SnakeIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Snake/SnakeCrawling.png',
			'time': 100
		},
	],
	'Tiger': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Tiger/TigerAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Tiger/TigerDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Tiger/TigerDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Tiger/TigerIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Aggressive/Tiger/TigerWalk.png',
			'time': 100
		},
	]
}

# frame timing not in files
var wildelife_docile := {
	'Badger': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Badger/BadgerDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Badger/BadgerDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Badger/BadgerIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Badger/BadgerWalk.png',
			'time': 100
		}
	],
	'Camel': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Camel/CamelDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Camel/CamelDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Camel/CamelIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Camel/CamelWalk.png',
			'time': 100
		}
	],
	'Cat': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Cat/CatDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Cat/CatDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Cat/CatIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Cat/CatWalk.png',
			'time': 100
		}
	],
	'Dog': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Dog/DogDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Dog/DogDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Dog/DogIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Dog/DogWalk.png',
			'time': 100
		}
	],
	'Elephant': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Elephant/ElephantDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Elephant/ElephantDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Elephant/ElephantIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Elephant/ElephantWalk.png',
			'time': 100
		}
	],
	'Frog': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Frog/GreenFrogDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Frog/GreenFrogDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Frog/GreenFrogIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Frog/GreenFrogWalk.png',
			'time': 100
		}
	],
	'GiantSnail': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/GiantSnail/GiantSnailDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/GiantSnail/GiantSnailDmg.png',
			'time': 100
		},
		{
			'name': 'idle_in',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/GiantSnail/GiantSnailInShell.png',
			'time': 100
		},
		{
			'name': 'idle_out',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/GiantSnail/GiantSnailOutShell.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/GiantSnail/GiantSnailCrawl.png',
			'time': 100
		}
	],
	'Goat': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Goat/GoatDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Goat/GoatDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Goat/GoatIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Goat/GoatWalk.png',
			'time': 100
		}
	],
	'Hedgehog': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hedgehog/HedgehogDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hedgehog/HedgehogDmg.png',
			'time': 100
		},
		{
			'name': 'idle_spike_out',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hedgehog/HedgehogSpikesOut.png',
			'time': 100
		},
		{
			'name': 'idle_spike_in',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hedgehog/HedgehogSpikesIn.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hedgehog/HedgehogWalk.png',
			'time': 100
		}
	],
	'Hippo': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hippo/HippoDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hippo/HippoDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hippo/HippoIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Hippo/HippoWalk.png',
			'time': 100
		}
	],
	'Horse': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Horse/HorseDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Horse/HorseDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Horse/HorseIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Horse/HorseWalk.png',
			'time': 100
		}
	],
	'Kangaroo': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Kangaroo/KangarooDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Kangaroo/KangarooDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Kangaroo/KangarooIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Kangaroo/KangarooHop.png',
			'time': 100
		}
	],
	'Moose': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Moose/MooseDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Moose/MooseDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Moose/MooseIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Moose/MooseWalk.png',
			'time': 100
		}
	],
	'Orange_Fox': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Orange Fox/OrangeFoxDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Orange Fox/OrangeFoxDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Orange Fox/OrangeFoxIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Orange Fox/OrangeFoxWalk.png',
			'time': 100
		}
	],
	'Ostrich': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Ostrich/OstrichDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Ostrich/OstrichDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Ostrich/OstrichIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Ostrich/OstrichWalk.png',
			'time': 100
		}
	],
	'Panda': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Panda/PandaDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Panda/PandaDmg.png',
			'time': 100
		},
		{
			'name': 'sleep',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Panda/PandaSleep.png',
			'time': 100
		},
		{
			'name': 'stand_up',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Panda/PandaStandUp.png',
			'time': 100
		},
		{
			'name': 'lay_down',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Panda/PandaLaydown.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Panda/PandaWalk.png',
			'time': 100
		}
	],
	'Platypus': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Platypus/PlatypusDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Platypus/PlatypusDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Platypus/PlatypusIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Platypus/PlatypusWalking.png',
			'time': 100
		}
	],
	'Polar_Fox': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Polar Fox/PolarFoxDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Polar Fox/PolarFoxDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Polar Fox/PolarFoxIdel.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Polar Fox/PolarFoxWalk.png',
			'time': 100
		}
	],
	'Skunk': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Skunk/SkunkDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Skunk/SkunkDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Skunk/SkunkIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Skunk/SkunkWalk.png',
			'time': 100
		}
	],
	'Squirrel': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Squirrel/SquirrelDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Squirrel/SquirrelDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Squirrel/SquirrelIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Squirrel/SquirrelWalk.png',
			'time': 100
		}
	],
	'Tortoise': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Tortoise/TortoiseDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Tortoise/TortoiseDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Tortoise/TortoiseIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_Wildlife_v1.0/Minifantasy_Wildlife_Assets/Non-Aggressive/Tortoise/TortoiseWalk.png',
			'time': 100
		}
	]
}

# frame timing not in files
var myraid_of_npc := {
	'Alchemist': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Alchemist/Minifantasy_NPCsAlchemistDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Alchemist/Minifantasy_NPCsAlchemistDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Alchemist/Minifantasy_NPCsAlchemistIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Alchemist/Minifantasy_NPCsAlchemistWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Alchemist/Minifantasy_NPCsAlchemistWorking.png',
			'time': 100
		}
	],
	'Blacksmith': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Blacksmith/Minifantasy_NPCsBlacksmithDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Blacksmith/Minifantasy_NPCsBlacksmithDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Blacksmith/Minifantasy_NPCsBlacksmithIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Blacksmith/Minifantasy_NPCsBlacksmithWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Blacksmith/Minifantasy_NPCsBlacksmithWorking.png',
			'time': 100
		}
	],
	'Butcher': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Butcher/Minifantasy_NPCsButcherDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Butcher/Minifantasy_NPCsButcherDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Butcher/Minifantasy_NPCsButcherIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Butcher/Minifantasy_NPCsButcherWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Butcher/Minifantasy_NPCsButcherWorking.png',
			'time': 100
		}
	],
	'Carpenter': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Carpenter/Minifantasy_NPCsCarpenterDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Carpenter/Minifantasy_NPCsCarpenterDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Carpenter/Minifantasy_NPCsCarpenterIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Carpenter/Minifantasy_NPCsCarpenterWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Carpenter/Minifantasy_NPCsCarpenterWorking.png',
			'time': 100
		}
	],
	'Cooker': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Cooker/Minifantasy_NPCsCookerDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Cooker/Minifantasy_NPCsCookerDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Cooker/Minifantasy_NPCsCookerIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Cooker/Minifantasy_NPCsCookerWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Cooker/Minifantasy_NPCsCookerWorking.png',
			'time': 100
		}
	],
	'Dyer': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Dyer/Minifantasy_NPCsDyerDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Dyer/Minifantasy_NPCsDyerDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Dyer/Minifantasy_NPCsDyerIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Dyer/Minifantasy_NPCsDyerWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Dyer/Minifantasy_NPCsDyerWorking.png',
			'time': 100
		}
	],
	'Furrier': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Furrier/Minifantasy_NPCsFurrierDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Furrier/Minifantasy_NPCsFurrierDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Furrier/Minifantasy_NPCsFurrierIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Furrier/Minifantasy_NPCsFurrierWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Furrier/Minifantasy_NPCsFurrierWorking.png',
			'time': 100
		}
	],
	'Jeweller': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Jeweller/Minifantasy_NPCsJewellerDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Jeweller/Minifantasy_NPCsJewellerDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Jeweller/Minifantasy_NPCsJewellerIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Jeweller/Minifantasy_NPCsJewellerWalk.png',
			'time': 200
		},
		{
			'name': 'work',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Jeweller/Minifantasy_NPCsJewellerWorking.png',
			'time': 100
		}
	],
	'Tailor': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Tailor/Minifantasy_NPCsTailorDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Tailor/Minifantasy_NPCsTailorDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Tailor/Minifantasy_NPCsTailorIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/Minifantasy_NPCs_Assets/Premade_NPCs/Tailor/Minifantasy_NPCsTailorWalk.png',
			'time': 200
		}
	]
}

# frame timing not in files
# need special animations
var heros_1 := {
	'Barbarian': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/General_Animations/Minifantasy_TrueHeroesBarbarianAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/General_Animations/Minifantasy_TrueHeroesBarbarianDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/General_Animations/Minifantasy_TrueHeroesBarbarianDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/General_Animations/Minifantasy_TrueHeroesBarbarianIdle.png',
			'time': 100
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/General_Animations/Minifantasy_TrueHeroesBarbarianJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/General_Animations/Minifantasy_TrueHeroesBarbarianWalk.png',
			'time': 100
		},
		{
			'name': 'battle_cry',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Battle_Cry/Minifantasy_TrueHeroesBarbarianBattleCry.png',
			'time': 100
		},
		{
			'name': 'battle_cry_back_layer',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Battle_Cry/Minifantasy_TrueHeroesBarbarianBattleCryEffectBackLayer.png',
			'time': 100
		},
		{
			'name': 'battle_cry_front_layer',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Battle_Cry/Minifantasy_TrueHeroesBarbarianBattleCryEffectFrontLayer.png',
			'time': 100
		},
		{
			'name': 'guard_down',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Guard/Minifantasy_TrueHeroesBarbarianBlockGuardDown.png',
			'time': 100
		},
		{
			'name': 'guard_up',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Guard/Minifantasy_TrueHeroesBarbarianBlockGuardUp.png',
			'time': 100
		},
		{
			'name': 'guard_impact',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Guard/Minifantasy_TrueHeroesBarbarianBlockImpact.png',
			'time': 100
		},
		{
			'name': 'throw_things',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Throw_Things/Minifantasy_TrueHeroesBarbarianThrowThings.png',
			'time': 100
		},
		{
			'name': 'Thunder_Blade_Attack',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Barbarian/Special_Animations/Thunder_Blade_Attack/Minifantasy_TrueHeroesBarbarianThunderBlade.png',
			'time': 100
		}
	],
	'Druid':  [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/General_Animations/Minifantasy_TrueHeroesDruidAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/General_Animations/Minifantasy_TrueHeroesDruidDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/General_Animations/Minifantasy_TrueHeroesDruidDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/General_Animations/Minifantasy_TrueHeroesDruidIdle.png',
			'time': 100
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/General_Animations/Minifantasy_TrueHeroesDruidJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/General_Animations/Minifantasy_TrueHeroesDruidWalk.png',
			'time': 100
		},
		{
			'name': 'root_summon',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/Special_Animations/Root_Summoning/Minifantasy_TrueHeroesDruidRootSummoning.png',
			'time': 100
		},
		{
			'name': 'root_attack',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Druid/Special_Animations/Root_Summoning/Minifantasy_TrueHeroesDruidRootAttack.png',
			'time': 100
		}
	],
	'Rogue':  [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Rogue/General_Animations/Minifantasy_TrueHeroesRogueAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Rogue/General_Animations/Minifantasy_TrueHeroesRogueDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Rogue/General_Animations/Minifantasy_TrueHeroesRogueDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Rogue/General_Animations/Minifantasy_TrueHeroesRogueIdle.png',
			'time': 100
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Rogue/General_Animations/Minifantasy_TrueHeroesRogueJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_TrueHeroes_v1.0/Rogue/General_Animations/Minifantasy_TrueHeroesRogueWalk.png',
			'time': 100
		}
	],
}

# need special animations
var heros_2 := {
	'Bard': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardIdle.png',
			'time': 200
		},
		{
			'name': 'idle_end',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardIdleEnd.png',
			'time': 200
		},
		{
			'name': 'idle_start',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardIdleStart.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Bard/General_Animations/BardWalk.png',
			'time': 200
		}
	],
	'Cleric': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericIdle.png',
			'time': 200
		},
		{
			'name': 'idle_end',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericIdleEnd.png',
			'time': 200
		},
		{
			'name': 'idle_start',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericIdleStart.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Cleric/General_Animations/ClericWalk.png',
			'time': 200
		}
	],
	'Paladin': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinDie.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinIdle.png',
			'time': 200
		},
		{
			'name': 'idle_end',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinIdleEnd.png',
			'time': 200
		},
		{
			'name': 'idle_start',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinIdleStart.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinJump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_True_Heroes_II_v1.0/Minifantasy_True_Heroes_II_Assets/Paladin/General_Animations/PaladinWalk.png',
			'time': 200
		}
	]
}

# need special animations
var heros_3 := {
	'Fighter': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_Idle.png',
			'time': 200
		},
		{
			'name': 'idle_special',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_Idle_Special.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_Jump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Fighter/General_Animations/Figther_walk.png',
			'time': 200
		}
	],
	'Ranger': [
		{
			'name': 'attack_orth',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_SingleShot_Orthogonal.png',
			'time': 100
		},
		{
			'name': 'attack_diag',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_SingleShot_Diagonal.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_Idle.png',
			'time': 200
		},
		{
			'name': 'idle_special',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_Idle_Special.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_Jump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Ranger/General_Animations/Ranger_walk.png',
			'time': 200
		}
	],
	'Wizard': [
		{
			'name': 'attack',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Idle.png',
			'time': 200
		},
		{
			'name': 'idle_special',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Idle_Special.png',
			'time': 200
		},
		{
			'name': 'jump',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Jump.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_True_Heroes_III_v1.0/Minifantasy_True_Herfoes_III_Assets/Wizard/General_Animations/Wizard_Walk.png',
			'time': 200
		}
	]
}

var customs := {
	'Orc_Green_Axe': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-axe-die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-axe-dmg.png',
			'time': 100
		},
		{
			'name': 'hit',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-axe-hit.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-axe-idle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-axe-walk.png',
			'time': 100
		}
	],
	'Orc_Green_Bow': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-bow-die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-bow-dmg.png',
			'time': 100
		},
		{
			'name': 'hit',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-bow-shot.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-bow-idle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-bow-walk.png',
			'time': 100
		}
	],
	'Orc_Green_Spear': [
		{
			'name': 'die',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-spear-die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-spear-dmg.png',
			'time': 100
		},
		{
			'name': 'hit',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-spear-hit.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-spear-idle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/Minifantasy_AMyriadOfNPCs_v.1.0/my_templates/orc/orc1-spear-walk.png',
			'time': 100
		}
	],
}

var exclusives := {
	'Air_Elemental': [
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Air_Elemental/AirElementalIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Air_Elemental/AirElementalWalk.png',
			'time': 200
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Air_Elemental/AirElementalDmg.png',
			'time': 100
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Air_Elemental/AirElementalAttackOrthogonal.png',
			'time': 100
		}
	],
	'Ancient_Troll': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Ancient_Troll/Minifantasy_AncientTrollAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Ancient_Troll/Minifantasy_AncientTrollDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Ancient_Troll/Minifantasy_AncientTrollDmg.png',
			'time': 100
		},
		{
			'name': 'eat',
			'path': 'res://asset/img/exclusives/Creatures/Ancient_Troll/Minifantasy_AncientTrollEat.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Ancient_Troll/Minifantasy_AncientTrollIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Ancient_Troll/Minifantasy_AncientTrollWalk.png',
			'time': 100
		}
	],
	'Ape_1': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_1/Ape_Attack.png',
			'time': 100
		},
		{
			'name': 'chest_hit',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_1/Ape_ChestHits.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_1/Ape_Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_1/Ape_Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_1/Ape_Idle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_1/Ape_Walk.png',
			'time': 100
		}
	],
	'Ape_2': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_2/Ape_Attack2.png',
			'time': 100
		},
		{
			'name': 'chest_hit',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_2/Ape_ChestHits2.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_2/Ape_Die2.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_2/Ape_Dmg2.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_2/Ape_Idle2.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Ape/Ape_2/Ape_Walk2.png',
			'time': 100
		}
	],
	'Armored_Warrior': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Armored_Warrior/Minifantasy_ArmoredWarriorAttack.png',
			'time': 100
		},
		{
			'name': 'charging',
			'path': 'res://asset/img/exclusives/Creatures/Armored_Warrior/Minifantasy_ArmoredWarriorCharging.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Armored_Warrior/Minifantasy_ArmoredWarriorDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Armored_Warrior/Minifantasy_ArmoredWarriorDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Armored_Warrior/Minifantasy_ArmoredWarriorIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Armored_Warrior/Minifantasy_ArmoredWarriorWalk.png',
			'time': 100
		}
	],
	'Beholder': [
		{
			'name': 'attack_360',
			'path': 'res://asset/img/exclusives/Creatures/Beholder/Minifantasy_Beholder360Attack.png',
			'time': 100
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Beholder/Minifantasy_BeholderAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Beholder/Minifantasy_BeholderDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Beholder/Minifantasy_BeholderDmg.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Beholder/Minifantasy_BeholderFly.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Beholder/Minifantasy_BeholderIdle.png',
			'time': 100
		}
	],
	'Diablo': [
		{
			'name': 'attack_2',
			'path': 'res://asset/img/exclusives/Creatures/Diablo/DiabloAttack2Orthogonal.png',
			'time': 100
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Diablo/DiabloAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Diablo/DiabloDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Diablo/DiabloDie.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Diablo/DiabloIdle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Diablo/DiabloWalk.png',
			'time': 200
		}
	],
	'Dire_Bear': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Dire_Bear/Minifantasy_BearAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Dire_Bear/Minifantasy_BearDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Dire_Bear/Minifantasy_BearDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Dire_Bear/Minifantasy_BearIdle.png',
			'time': 100
		},
		{
			'name': 'sleep',
			'path': 'res://asset/img/exclusives/Creatures/Dire_Bear/Minifantasy_BearSleep.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Dire_Bear/Minifantasy_BearWalk.png',
			'time': 100
		}
	],
	'Dragon': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonAttackContinuous.png',
			'time': 100
		},
		{
			'name': 'attack_start',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonAttackStart.png',
			'time': 100
		},
		{
			'name': 'attack_end',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonAttackEnd.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Dragon/DragonWalk.png',
			'time': 100
		}
	],
	'Dragon_Hatchling': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Dragon_Hatchling/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Dragon_Hatchling/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Dragon_Hatchling/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Dragon_Hatchling/Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Dragon_Hatchling/Walk.png',
			'time': 200
		}
	],
	'Dwarven_Marksman': [
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Idle.png',
			'time': 200
		},
		{
			'name': 'reload',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Reload.png',
			'time': 200
		},
		{
			'name': 'set_trap',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Set_Trap.png',
			'time': 200
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Shot_Orthogonal.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Dwarven_Marksman/Walk.png',
			'time': 200
		}
	],
	'Farmer': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerDmg.png',
			'time': 100
		},
		{
			'name': 'hoe',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerHoe.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerWalk2.png',
			'time': 100
		},
		{
			'name': 'watering',
			'path': 'res://asset/img/exclusives/Creatures/Farmer/Minifantasy_FarmerWateringCan2.png',
			'time': 100
		}
	],
	'Giant_Spider': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Giant_Spider/Minifantasy_GiantSpiderAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Giant_Spider/Minifantasy_GiantSpiderDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Giant_Spider/Minifantasy_GiantSpiderDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Giant_Spider/Minifantasy_GiantSpiderIdle.png',
			'time': 100
		},
		{
			'name': 'shoot',
			'path': 'res://asset/img/exclusives/Creatures/Giant_Spider/Minifantasy_GiantSpiderShotWebOrthogonal.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Giant_Spider/Minifantasy_GiantSpiderWalk.png',
			'time': 100
		}
	],
	'Griffin': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Dmg.png',
			'time': 100
		},
		{
			'name': 'fly',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Fly.png',
			'time': 200
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Idle.png',
			'time': 200
		},
		{
			'name': 'landing',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Landing.png',
			'time': 200
		},
		{
			'name': 'take_off',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Take_Off.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Griffin/Walk.png',
			'time': 200
		}
	],
	'Grim_Reaper': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Grim_Reaper/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Grim_Reaper/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Grim_Reaper/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Grim_Reaper/Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Grim_Reaper/Walk.png',
			'time': 200
		}
	],
	'Headless_Horseman': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Headless_Horseman/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Headless_Horseman/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Headless_Horseman/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Headless_Horseman/Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Headless_Horseman/Walk.png',
			'time': 200
		}
	],
	'Insect_Swarm': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Insect_Swarm/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Insect_Swarm/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Insect_Swarm/Dmg.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Insect_Swarm/Fly_Orthogonal.png',
			'time': 200
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Insect_Swarm/Idle.png',
			'time': 200
		}
	],
	'King': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/King/Minifantasy_kingAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/King/Minifantasy_kingDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/King/Minifantasy_kingDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/King/Minifantasy_kingIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/King/Minifantasy_kingWalk.png',
			'time': 100
		}
	],
	'King_Skeleton': [
		{
			'name': 'deactivate',
			'path': 'res://asset/img/exclusives/Creatures/King_Skeleton/Minifantasy_KingSkeletonActivationDeactivation.png',
			'time': 100
		},
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/King_Skeleton/Minifantasy_KingSkeletonAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/King_Skeleton/Minifantasy_KingSkeletonDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/King_Skeleton/Minifantasy_KingSkeletonDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/King_Skeleton/Minifantasy_KingSkeletonIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/King_Skeleton/Minifantasy_KingSkeletonWalk.png',
			'time': 100
		}
	],
	'Lich': [
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Lich/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Lich/Dmg.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Lich/Fly.png',
			'time': 200
		},
		{
			'name': 'cast_ice_claws',
			'path': 'res://asset/img/exclusives/Creatures/Lich/Spellcast_ice_claws.png',
			'time': 200
		},
		{
			'name': 'cast_reanimation',
			'path': 'res://asset/img/exclusives/Creatures/Lich/Spellcast_reanimation.png',
			'time': 200
		}
	],
	'Merchant': [
		{
			'name': 'stall_idle',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchanStalltIdle.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchantDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchantDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchantIdle.png',
			'time': 100
		},
		{
			'name': 'stall_pack_back',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchantStallPackBack.png',
			'time': 100
		},
		{
			'name': 'stall_setup',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchantStallSetup.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Merchant/Minifantasy_MerchantWalk.png',
			'time': 100
		}
	],
	'Mouse': [
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Mouse/MouseDie.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Mouse/MouseIdle.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Mouse/MouseWalk.png',
			'time': 100
		}
	],
	'Mushroom_people': [
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Mushroom_people/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Mushroom_people/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Mushroom_people/Idle.png',
			'time': 100
		}
	],
	'Naga': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Naga/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Naga/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Naga/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Naga/Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Naga/Walk.png',
			'time': 200
		}
	],
	'Necromancer': [
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Necromancer/Necromancer_Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Necromancer/Necromancer_Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Necromancer/Necromancer_Idle.png',
			'time': 200
		},
		{
			'name': 'spellcast',
			'path': 'res://asset/img/exclusives/Creatures/Necromancer/Necromancer_Spellcast.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Necromancer/Necromancer_Walk.png',
			'time': 200
		}
	],
	'Orc_Knight': [
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Orc_Knight/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Orc_Knight/Dmg.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Orc_Knight/Gallop.png',
			'time': 200
		}
	],
	'Human_Town_Guard': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Human Town Guard/Guards_Attack_human.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Human Town Guard/Guards_Die_human.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Human Town Guard/Guards_Dmg_human.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Human Town Guard/Guards_Idle_human.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Human Town Guard/Guards_Walk_human.png',
			'time': 200
		}
	],
	'Orc_Town_Guard': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Orc Town Guard/Guards_Attack_orc.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Orc Town Guard/Guards_Die_orc.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Orc Town Guard/Guards_Dmg_orc.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Orc Town Guard/Guards_Idle_orc.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Orc Town Guard/Guards_Walk_orc.png',
			'time': 200
		}
	],
	'Dwarf_Town_Guard': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Dwarf Town Guard/Guards_Attack_dwarf.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Dwarf Town Guard/Guards_Die_dwarf.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Dwarf Town Guard/Guards_Dmg_dwarf.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Dwarf Town Guard/Guards_Idle_dwarf.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Town_Guards/Dwarf Town Guard/Guards_Walk_dwarf.png',
			'time': 200
		}
	],
	'Undead_Knight': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Undead_Knight/Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Undead_Knight/Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Undead_Knight/Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Undead_Knight/Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Undead_Knight/Walk.png',
			'time': 200
		}
	],
	'Wise_Orc': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Wise_Orc/WiseOrc_Attack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Wise_Orc/WiseOrc_Die.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Wise_Orc/WiseOrc_Dmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Wise_Orc/WiseOrc_Idle.png',
			'time': 200
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Wise_Orc/WiseOrc_Walk.png',
			'time': 200
		}
	],
	'Wraith': [
		{
			'name': 'attack',
			'path': 'res://asset/img/exclusives/Creatures/Wraith/Minifantasy_WraithAttack.png',
			'time': 100
		},
		{
			'name': 'die',
			'path': 'res://asset/img/exclusives/Creatures/Wraith/Minifantasy_WraithDie.png',
			'time': 100
		},
		{
			'name': 'dmg',
			'path': 'res://asset/img/exclusives/Creatures/Wraith/Minifantasy_WraithDmg.png',
			'time': 100
		},
		{
			'name': 'idle',
			'path': 'res://asset/img/exclusives/Creatures/Wraith/Minifantasy_WraithFloating.png',
			'time': 100
		},
		{
			'name': 'walk',
			'path': 'res://asset/img/exclusives/Creatures/Wraith/Minifantasy_WraithFloating.png',
			'time': 100
		}
	]
}

var diff_size := {
	'Dragon': Vector2(64.0, 64.0),
}

var units := [
	undead_creatures,
	creatures,
	wildlife_aggressive,
	wildelife_docile,
	myraid_of_npc,
	heros_1,
	heros_2,
	heros_3,
	customs,
	exclusives,
]


func _ready():
	get_unique_anim_type_names()
	make_import_library(true)
	make_state_machines()
	make_character_icons()

func make_import_library(new_file:= false):
	var dir_access := DirAccess.open('res://resource/animation/')
	for i in range(units.size()):
		for unit_name in units[i]:
			if new_file:
				dir_access.remove('%s.tres' % unit_name)
			for anim_data in units[i][unit_name]:
				anim_importer.import_anim_file(anim_data['path'],
					unit_name, anim_data['name'], anim_data['time'],
						diff_size.get(unit_name, anim_importer.FRAME_SIZE))

func make_state_machines(exlude_unit:= []):
	for i in range(units.size()):
		for unit_name in units[i]:
			if exlude_unit.has(unit_name):
				continue
			var file_path := 'res://resource/animation/%s.tres' % unit_name
			var anim_template_names := []
			for anim_data in units[i][unit_name]:
				anim_template_names.append(anim_data['name'])
			anim_importer.create_state_machine(unit_name, file_path, anim_template_names)

func get_unique_anim_type_names():
	var unique_values := {}
	for i in range(units.size()):
		for unit_name in units[i]:
			for anim_data in units[i][unit_name]:
				unique_values[anim_data['name']] = null
	print(unique_values.keys())

func make_character_icons():
	for i in range(units.size()):
		for unit_name in units[i]:
			var idle_img_path := ''
			for anim_data in units[i][unit_name]:
				if anim_data['name'] == 'idle':
					idle_img_path = anim_data['path']
					break
			if idle_img_path.is_empty():
				print('make_character_icons: [%s] has no [idle] anim.' % unit_name)
			else:
				anim_importer.make_character_icon(idle_img_path, unit_name,
					diff_size.get(unit_name, anim_importer.FRAME_SIZE))
