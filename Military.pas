unit Military;

interface

type
  IBlaster = interface
    procedure Fire(const ADirection: String);
  end;

  ILoadable = interface
    procedure LoadAmmo(const Count: Integer);
  end;

  TCannon = class(TInterfacedObject, ILoadable, IBlaster)
  strict private
    FClip: Integer;
  public
    constructor Create;
    procedure Fire(const ADirection: String);
    procedure LoadAmmo(const Count: Integer);
  end;

  TCatapult = class(TInterfacedObject, ILoadable, IBlaster)
  strict private
    FClip: Integer;
  public
    constructor Create;
    procedure Fire(const ADirection: String);
    procedure LoadAmmo(const Count: Integer);
  end;

  TMilitary = class
  strict private
    FCannon: TCannon;
    FCatapult: TCatapult;
  private
    procedure UseTheCannon;
    procedure UseTheCatapult;
  public
    constructor Create;
    destructor Destroy; override;
    procedure KillTheEnemy;
  end;

implementation

uses
  System.SysUtils;

type
  TSoldierFiveShooter = class
  strict private
    FBlaster: IBlaster;
  public
    constructor Create(ABlaster: IBlaster);
    procedure Attack;
  end;

  TSolderFourLoader = class
  strict private
    FLoadable: ILoadable;
  public
    constructor Create(ALoadable: ILoadable);
    procedure Load;
  end;

  TSolderOneLoader = class
  strict private
    FLoadable: ILoadable;
  public
    constructor Create(ALoadable: ILoadable);
    procedure Load;
  end;

type
  TSoldierOneShooter = class
  strict private
    FBlaster: IBlaster;
  public
    constructor Create(ABlaster: IBlaster);
    procedure Attack;
  end;

constructor TSoldierFiveShooter.Create(ABlaster: IBlaster);
begin
  inherited Create;
  FBlaster := ABlaster;
end;

procedure TSoldierFiveShooter.Attack;
begin
  FBlaster.Fire('North');
  FBlaster.Fire('South');
  FBlaster.Fire('East');
  FBlaster.Fire('West');
  FBlaster.Fire('Up');
end;

constructor TSolderFourLoader.Create(ALoadable: ILoadable);
begin
  inherited Create;
  FLoadable := ALoadable;
end;

procedure TSolderFourLoader.Load;
begin
  FLoadable.LoadAmmo(4);
end;

procedure TMilitary.UseTheCannon;
var
  Loader: TSolderFourLoader;
  Shooter: TSoldierFiveShooter;
begin
  Loader := TSolderFourLoader.Create(FCannon);
  Shooter := TSoldierFiveShooter.Create(FCannon);
  try
    Loader.Load;
    Shooter.Attack;
  finally
    Shooter.Free;
    Loader.Free;
  end;
end;

procedure TMilitary.UseTheCatapult;
var
  Loader: TSolderFourLoader;
  Shooter: TSoldierFiveShooter;
begin
  Loader := TSolderFourLoader.Create(FCatapult);
  Shooter := TSoldierFiveShooter.Create(FCatapult);
  try
    Loader.Load;
    Shooter.Attack;
  finally
    Shooter.Free;
    Loader.Free;
  end;
end;

constructor TMilitary.Create;
begin
  inherited Create;
  FCannon := TCannon.Create();
  FCatapult := TCatapult.Create();
end;

destructor TMilitary.Destroy;
begin
  FCatapult.Free;
  FCannon.Free;
  inherited Destroy;
end;

procedure TMilitary.KillTheEnemy;
begin
  UseTheCannon;
  UseTheCatapult;
  UseTheCannon;
  ReadLn;
end;

constructor TCannon.Create;
begin
  inherited Create;
  FClip := 0;
end;

procedure TCannon.Fire(const ADirection: String);
begin
  if FClip > 0 then
  begin
    WriteLn('Firing: Pew! Pew! to the ' + ADirection);
    Dec(FClip);
  end
  else
  begin
    WriteLn('Fireing: Click. Click.');
  end;
end;

procedure TCannon.LoadAmmo(const Count: Integer);
begin
  FClip := FClip + Count;
  WriteLn('Added: ' + Count.ToString);
end;

constructor TCatapult.Create;
begin
  inherited Create;
  FClip := 0;
end;

procedure TCatapult.Fire(const ADirection: String);
begin
  if FClip > 0 then
  begin
    WriteLn('Firing: Swish to the ' + ADirection);
    Dec(FClip);
  end
  else
  begin
    WriteLn('Fireing: Silence');
  end;
end;

procedure TCatapult.LoadAmmo(const Count: Integer);
begin
  FClip := FClip + Count;
  WriteLn('Added: ' + Count.ToString);
end;

constructor TSolderOneLoader.Create(ALoadable: ILoadable);
begin
  inherited Create;
  FLoadable := ALoadable;
end;

procedure TSolderOneLoader.Load;
begin
  FLoadable.LoadAmmo(1);
end;

constructor TSoldierOneShooter.Create(ABlaster: IBlaster);
begin
  inherited Create;
  FBlaster := ABlaster;
end;

procedure TSoldierOneShooter.Attack;
begin
  FBlaster.Fire('North');
  FBlaster.Fire('South');
  FBlaster.Fire('East');
  FBlaster.Fire('West');
  FBlaster.Fire('Up');
end;

end.
