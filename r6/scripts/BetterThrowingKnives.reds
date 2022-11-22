// BetterThrowingKnives, Cyberpunk 2077 mod that improves throwing knives
// Copyright (C) 2022 BurgersMcFly

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

@replaceMethod(Knife) 

   protected cb func OnProjectileInitialize(eventData: ref<gameprojectileSetUpEvent>) -> Bool {
    let statPoolsSystem: ref<StatPoolsSystem>;
    super.OnProjectileInitialize(eventData);
    this.m_projectileStopped = false;
    this.m_collided = false;
    this.m_wasPicked = false;
    this.m_isActive = true;
    this.m_hasHitWater = false;
    this.m_waterHeight = 0.00;
    this.m_deactivationDepth = this.GetProjectileTweakDBFloatParameter("deactivationDepth");
    this.m_waterImpulseRadius = this.GetProjectileTweakDBFloatParameter("waterImpulseRadius");
    this.m_waterImpulseStrength = this.GetProjectileTweakDBFloatParameter("waterImpulseStrength");
    this.m_projectileCollisionEvaluator = new KnifeCollisionEvaluator();
    this.m_projectileComponent.SetCollisionEvaluator(this.m_projectileCollisionEvaluator);
    this.m_weapon = eventData.weapon;
    statPoolsSystem = GameInstance.GetStatPoolsSystem(this.GetGame());
    
    this.m_throwingKnifeResourcePoolListener = new ThrowingKnifeReloadListener();
    this.m_throwingKnifeResourcePoolListener.Bind(this);
    statPoolsSystem.RequestRegisteringListener(Cast<StatsObjectID>(this.m_weapon.GetEntityID()), gamedataStatPoolType.ThrowRecovery, this.m_throwingKnifeResourcePoolListener);
    GameObject.TagObject(this);
  }

@replaceMethod(Knife) 

  protected cb func OnCollision(eventData: ref<gameprojectileHitEvent>) -> Bool {
    let effect: FxResource;
    let effectTransform: WorldTransform;
    let enableInteractionEvent: ref<InteractionSetEnableEvent>;
    let hitEvent: ref<gameprojectileHitEvent>;
    let hitInstance: gameprojectileHitInstance;
    let i: Int32;
    let isObjectNPC: Bool;
    if !this.m_isActive {
      return false;
    };
    super.OnCollision(eventData);
    i = 0;
    while i < ArraySize(eventData.hitInstances) {
      hitInstance = eventData.hitInstances[i];
      if hitInstance.isWaterSurfaceImpact {
        this.m_hasHitWater = true;
        this.m_waterHeight = hitInstance.position.Z;
        effect = this.m_resourceLibraryComponent.GetResource(n"splash_effect");
        if FxResource.IsValid(effect) {
          WorldTransform.SetPosition(effectTransform, hitInstance.position);
          GameInstance.GetFxSystem(this.GetGame()).SpawnEffect(effect, effectTransform);
        };
        RenderingSystem.AddWaterImpulse(hitInstance.position, this.m_waterImpulseRadius, this.m_waterImpulseStrength);
      } else {
        enableInteractionEvent = new InteractionSetEnableEvent();
        enableInteractionEvent.enable = true;
        this.QueueEvent(enableInteractionEvent);
        if !this.m_hasHitWater || hitInstance.position.Z - this.m_waterHeight > this.m_deactivationDepth {
          if !this.m_projectileStopped {
            hitEvent = new gameprojectileHitEvent();
            ArrayPush(hitEvent.hitInstances, hitInstance);
            this.ProjectileHit(hitEvent);
          };
          if this.m_projectileCollisionEvaluator.ProjectileStopAndStick() {
            this.m_projectileStopped = true;
          };
          isObjectNPC = this.GetObject(hitInstance).IsNPC();
          if !(isObjectNPC || this.GetObject(hitInstance).IsDrone()) {
            this.TriggerSingleStimuli(hitInstance, gamedataStimType.SoundDistraction);
          };
          if !this.m_wasPicked {
            this.m_wasPicked = true;
            this.Release();
          }  
        };
        break;
      };
      i += 1;
    };
  }