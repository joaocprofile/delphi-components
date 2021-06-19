unit JcProgressBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Math;

type
  TProgressBarKind = (bkFlat, bkCylinder);
  TProgressBarLook = (blMetal, blGlass);
  TProgressBarOrientation = (boHorizontal, boVertical);

  TRGBArray = array[0..2] of Byte;
  TCLRArray = array of TColor;
  THLSRange = 0..240;

  THLSRec = record
    hue: THLSRange;
    lum: THLSRange;
    sat: THLSRange;
  end;

  TPosDescr = record
    isInBlock: Boolean;
    blkLimit: Integer;
  end;

  TJcProgressBar = class(TCustomControl)
  private
    FPosDescr: array of TPosDescr;
    FPixDescr: array of TCLRArray;
    FInactDescr: TCLRArray;
    FInitsLocked: Boolean;
    FBarKind: TProgressBarKind;
    FBarLook: TProgressBarLook;
    FOrientation: TProgressBarOrientation;
    FInternalBorder: Integer;
    FUSefullDrawSpace: Integer;
    FBorderSize: Integer;
    FHasShape: Boolean;
    FShapeClr: TColor;
    FCorner: Integer;
    FStartClr: TColor;
    FFinalClr: TColor;
    FBkgClr: TColor;
    FMonoClr: Boolean;
    FInvInactPos: Boolean;
    FShowInactPos: Boolean;
    FInactPosClr: TColor;
    FUSerPosPct: Real;
    FUserPos: Integer;
    FPosition: Integer;
    FMinVisPos: Integer;
    FMaxPos: Integer;
    FByBlock: Boolean;
    FFullBlock: Boolean;
    FSpaceSize: Integer;
    FBlockSize: Integer;
    FHideOnTerm: Boolean;
    FCaption: string;
    FCapAlign: TAlignment;
    FCapPos: TPoint;
    FHasCaption: Boolean;
    FShowPosAsPct: Boolean;
    FCaptionOvr: Boolean;
    FHintOvr: Boolean;
    FStep: Integer;
    FOnPositionChange: TNotifyEvent;
    procedure SetStep(const Value: Integer);
  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure SetUsefullWidth;
    procedure InitBlockArray;
    procedure InitPixArray;
    function MakeCylinder(h: real): extended;
    function GetGradientAr2(aColor: TColor; sz: Integer): TClrArray;
    function HLStoRGB(hue, lum, sat: THLSRange): TColor;
    function RGBtoHLS(RGBColor: TColor): THLSRec;
    function GetColorBetween(StartColor, EndColor: TColor; Pointvalue,
      Von, Bis: Extended): TColor;
    procedure SetOrientation(value: TProgressBarOrientation);
    procedure SetBarKind(value: TProgressBarKind);
    procedure SetBarLook(value: TProgressBarLook);
    procedure SetFCorner(isRounded: Boolean);
    function GetBoolCorner: Boolean;
    procedure SetBkgColor(aColor: TColor);
    procedure SetShape(value: Boolean);
    procedure SetShapeColor(value: TColor);
    procedure SetBlockSize(value: Integer);
    procedure SetSpaceSize(value: Integer);
    procedure SetFullBlock(value: Boolean);
    procedure SetMaxPos(value: Integer);
    procedure SetPosition(value: Integer);
    procedure SetStartClr(value: TColor);
    procedure SetFinalClr(value: TColor);
    procedure SetBothColors(value: TColor);
    procedure SetInactivePos(value: Boolean);
    procedure SetInactPosClr(value: TColor);
    procedure SetInvInactPos(value: Boolean);
    procedure SetCaption(value: string);
    procedure SetCapAlign(value: TAlignment);
    procedure SetCaptionOvr(value: Boolean);
    procedure DoPositionChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LockInits;
    procedure StepIt;
    procedure StepBy(Delta: Integer);
    procedure UnlockInits;
  published
    property AutoCaption: Boolean read FCaptionOvr write SetCaptionOvr;
    property AutoHint: Boolean read FHintOvr write fHintOvr;
    property BackgroundColor: TColor read FBkgClr write SetBkgColor
      default clWhite;
    property BarColor: TColor read FStartClr write SetBothColors default
      TColor($00C3894B);
    property BarKind: TProgressBarKind read FBarKind write SetBarKind
      default bkCylinder;
    property BarLook: TProgressBarLook read FBarLook write SetBarLook default
      blGlass;
    property BlockSize: Integer read FBlockSize write SetBlockSize default 5;
    property Caption: string read FCaption write SetCaption;
    property CaptionAlign: TAlignment read FCapAlign write SetCapAlign default
      taLeftJustify;
    property FinalColor: TColor read FFinalClr write SetFinalClr default
      TColor($00C3894B);
    property Font;
    property Height;
    property HideOnTerminate: Boolean read FHideOnTerm write fHideOnTerm default
      False;
    property InvertInactPos: Boolean read FInvInactPos write SetInvInactPos;
    property InactivePosColor: TColor read FInactPosClr write SetInactPosClr
      default clGray;
    property Maximum: Integer read FMaxPos write SetMaxPos;
    property OnPositionChange: TNotifyEvent read FOnPositionChange write
      FOnPositionChange;
    property Orientation: TProgressBarOrientation read fOrientation write
      SetOrientation default boHorizontal;
    property Position: Integer read FUserPos write SetPosition;
    property RoundCorner: Boolean read GetBoolCorner write SetFCorner
      default True;
    property ShapeColor: TColor read FShapeClr write SetShapeColor default
      TColor($00C3894B);
    property Shaped: Boolean read FHasShape write SetShape default True;
    property ShowFullBlock: Boolean read FFullBlock write SetFullBlock;
    property ShowInactivePos: Boolean read FShowInactPos write SetInactivePos;
    property ShowPosAsPct: Boolean read FShowPosAsPct write fShowPosAsPct;
    property SpaceSize: Integer read FSpaceSize write SetSpaceSize default 1;
    property StartColor: TColor read FStartClr write SetStartClr;
    property Step: Integer read FStep write SetStep default 10;
    property Visible;
    property Width;

  end;

procedure Register;

const
  HLSMAX = High(THLSRange);
  RGBMAX = 255;
  UNDEFINED = HLSMAX * 2 div 3;

implementation

procedure Register;
begin
  RegisterComponents('Jc Components', [TJcProgressBar]);
end;

procedure TJcProgressBar.InitBlockArray;
var
  i, blkStart, blkStop: Integer;
begin
  if (fBlockSize = 0) or (fSpaceSize = 0) then
    exit;

  if fUSefullDrawSpace <= 0 then
    SetLength(Self.fPosDescr, 1)
  else
    SetLength(Self.fPosDescr, fUSefullDrawSpace + 1);

  case Self.fOrientation of
    boHorizontal:
      begin
        fPosDescr[0].isInBlock := False;
        blkStart := 3;
        blkStop := blkStart + fBlockSize - 1;
        for i := 1 to High(fPosDescr) do
        begin
          fPosDescr[i].isInBlock := (i >= blkStart) and (i <= blkStop);
          fPosDescr[i].blkLimit := blkStop;
          if i = blkStop then
          begin
            blkStart := blkStop + fSpaceSize + 1;
            blkStop := blkStart + fBlockSize - 1;
            if blkStop > High(fPosDescr) then
              blkStop := High(fPosDescr);
          end;
        end;
      end;
  else
    begin
      fPosDescr[High(fPosDescr)].isInBlock := False;
      blkStart := High(fPosDescr) - 3;
      blkStop := blkStart - fBlockSize + 1;
      for i := fUSefullDrawSpace downto fBorderSize do
      begin
        fPosDescr[i].isInBlock := (i <= blkStart) and (i >= blkStop);
        fPosDescr[i].blkLimit := blkStop;
        if i = blkStop then
        begin
          blkStart := blkStop - fSpaceSize - 1;
          blkStop := blkStart - fBlockSize + 1;
          if blkStop < fBorderSize then
            blkStop := fBorderSize;
        end;
      end;
    end;
  end;
end;

procedure TJcProgressBar.InitPixArray;
var
  i, j,
    rowSz: integer;
  clr: TColor;
  HLSr: THLSRec;
begin
  if Self.fInitsLocked then
    exit;
  case fOrientation of
    boHorizontal: rowSz := Height - (fBorderSize) + 1;
  else
    rowSz := Width - (fBorderSize) + 1;
  end;

  if fUSefullDrawSpace <= 0 then
    SetLength(fPixDescr, 1)
  else
    SetLength(fPixDescr, fUSefullDrawSpace + 1);

  for i := 0 to fUSefullDrawSpace do
  begin
    clr := GetColorBetween(fStartClr, fFinalClr, (i), 0, fUSefullDrawSpace);
    if fBarKind = bkCylinder then
      Self.fPixDescr[i] := GetGradientAr2(clr, rowSz)
    else
      for j := 0 to rowSz - 1 do
      begin
        SetLength(fPixDescr[i], rowSz);
        fPixDescr[i, j] := clr;
      end;
  end;

  if (Height - fBorderSize) <= 0 then
  begin
    SetLEngth(fInactDescr, 1);
    fInactDescr[0] := self.fInactPosClr;
  end
  else
  begin
    if fBarKind = bkCylinder then
      fInactDescr := GetGradientAr2(fInactPosClr, rowSz)
    else
    begin
      SetLength(fInactDescr, rowSz);
      for j := 0 to rowSz - 1 do
        fInactDescr[j] := fInactPosClr;
    end;
  end;

  if (fBarKind = bkCylinder) and (fInvInactPos) then
    for i := 0 to rowSz - 1 do
    begin
      HLSr := RGBtoHLS(fInactDescr[i]);
      HLSr.lum := 240 - HLSr.lum;
      fInactDescr[i] := HLStoRGB(HLSr.hue, HLSr.lum, HLSr.sat);
    end;

end;

function TJcProgressBar.MakeCylinder(h: real): extended;
begin
  result := ((-4342.9 * (power(h, 5)))
    + (10543 * (power(h, 4)))
    - (8216 * (power(h, 3)))
    + (2018.1 * (power(h, 2)))
    + (11.096 * h) + 164.6);
end;

function TJcProgressBar.GetGradientAr2(aColor: TColor; sz: Integer): TClrArray;
var
  i, RP: Integer;
  HLSr: THLSRec;
begin
  SetLength(result, sz);
  for i := 0 to sz - 1 do
  begin
    HLSr := RGBtoHLS(aColor);
    if self.fBarLook = blGlass then
      HLSr.lum := Round(MakeCylinder((i / sz)))
    else
    begin
      rp := HLSr.lum - 212;
      rp := rp + Trunc(MakeCylinder(i / sz));
      if rp < 0 then
        rp := 0;
      if rp > 240 then
        rp := 240;
      HLSr.lum := rp;
    end;
    result[i] := HLStoRGB(HLSr.hue, HLSr.lum, HLSr.sat);
  end;
end;

function TJcProgressBar.RGBtoHLS(RGBColor: TColor): THLSRec;
var
  R, G, B: Integer;
  H, L, S: Integer;
  cMax, cMin: Byte;
  Rdelta, Gdelta, Bdelta: Integer;
begin
  R := GetRValue(RGBColor);
  G := GetGValue(RGBColor);
  B := GetBValue(RGBColor);

  cMax := max(max(R, G), B);
  cMin := min(min(R, G), B);
  L := (((cMax + cMin) * HLSMAX) + RGBMAX) div (2 * RGBMAX);

  if (cMax = cMin) then
  begin
    S := 0;
    H := UNDEFINED;
  end
  else
  begin
    if (L <= (HLSMAX div 2)) then
      S := (((cMax - cMin) * HLSMAX) + ((cMax + cMin) div 2)) div (cMax + cMin)
    else
      S := (((cMax - cMin) * HLSMAX) + ((2 * RGBMAX - cMax - cMin) div 2)) div (2
        * RGBMAX - cMax - cMin);
    Rdelta := (((cMax - R) * (HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax
      - cMin);
    Gdelta := (((cMax - G) * (HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax
      - cMin);
    Bdelta := (((cMax - B) * (HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax
      - cMin);

    if R = cMax then
      H := Bdelta - Gdelta
    else if G = cMax then
      H := (HLSMAX div 3) + Rdelta - Bdelta
    else
      H := ((2 * HLSMAX) div 3) + Gdelta - Rdelta;
    if (H < 0) then
      H := H + HLSMAX;
    if (H > HLSMAX) then
      H := H - HLSMAX;
  end;

  Result.Hue := H;
  Result.Lum := L;
  Result.Sat := S;
end;

function TJcProgressBar.HLStoRGB(hue, lum, sat: THLSRange): TColor;
var
  R, G, B: Integer;
  Magic1, Magic2: Integer;

  function HueToRGB(n1, n2, hue: Integer): Integer;
  begin
    if hue < 0 then
      Inc(hue, HLSMAX)
    else if hue > HLSMAX then
      Dec(hue, HLSMAX);

    if hue < (HLSMAX div 6) then
      result := (n1 + (((n2 - n1) * hue + (HLSMAX div 12)) div (HLSMAX div 6)))
    else if hue < (HLSMAX div 2) then
      result := n2
    else if hue < ((HLSMAX * 2) div 3) then
      result := (n1 + (((n2 - n1) * (((HLSMAX * 2) div 3) - hue)
        + (HLSMAX div 12)) div (HLSMAX div 6)))
    else
      result := n1;
  end;

begin
  if Sat = 0 then
  begin
    R := (Lum * RGBMAX) div HLSMAX;
    G := R;
    B := R;
    {if not (Hue = UNDEFINED) then
    begin

    end;}
  end
  else
  begin
    if (Lum <= (HLSMAX div 2)) then
      Magic2 := (Lum * (HLSMAX + Sat) + (HLSMAX div 2)) div HLSMAX
    else
      Magic2 := Lum + Sat - ((Lum * Sat) + (HLSMAX div 2)) div HLSMAX;
    Magic1 := 2 * Lum - Magic2;

    R := (HueToRGB(Magic1, Magic2, Hue + (HLSMAX div 3)) * RGBMAX + (HLSMAX div
      2)) div HLSMAX;
    G := (HueToRGB(Magic1, Magic2, Hue) * RGBMAX + (HLSMAX div 2)) div HLSMAX;
    B := (HueToRGB(Magic1, Magic2, Hue - (HLSMAX div 3)) * RGBMAX + (HLSMAX div
      2)) div HLSMAX;
  end;
  Result := RGB(R, G, B);
end;

function TJcProgressBar.GetColorBetween(StartColor, EndColor: TColor;
  Pointvalue,
  Von, Bis: Extended): TColor;
var
  F: Extended;
  r1, r2, r3, g1, g2, g3, b1, b2, b3: Byte;
  function CalcColorBytes(fb1, fb2: Byte): Byte;
  begin
    result := fb1;
    if fb1 < fb2 then
      Result := FB1 + Trunc(F * (fb2 - fb1));
    if fb1 > fb2 then
      Result := FB1 - Trunc(F * (fb1 - fb2));
  end;
begin
  if (fMonoClr) or (Pointvalue <= Von) then
  begin
    result := StartColor;
    exit;
  end;
  if Pointvalue >= Bis then
  begin
    result := EndColor;
    exit;
  end;
  F := (Pointvalue - von) / (Bis - Von);
  asm
     mov EAX, Startcolor
     cmp EAX, EndColor
     je @@exit
     mov r1, AL
     shr EAX,8
     mov g1, AL
     shr Eax,8
     mov b1, AL
     mov Eax, Endcolor
     mov r2, AL
     shr EAX,8
     mov g2, AL
     shr EAX,8
     mov b2, AL
     push ebp
     mov al, r1
     mov dl, r2
     call CalcColorBytes
     pop ecx
     push ebp
     Mov r3, al
     mov dL, g2
     mov al, g1
     call CalcColorBytes
     pop ecx
     push ebp
     mov g3, Al
     mov dL, B2
     mov Al, B1
     call CalcColorBytes
     pop ecx
     mov b3, al
     XOR EAX,EAX
     mov AL, B3
     SHL EAX,8
     mov AL, G3
     SHL EAX,8
     mov AL, R3
@@Exit:
     mov @result, eax
  end;
end;

procedure TJcProgressBar.Paint;
var
  i, k, sp: Integer;
  OldBkMode: integer;
begin
  if Self.fHasShape then
    with Canvas do
    begin
      Pen.Width := 1;
      Brush.Style := bsSolid;
      Brush.Color := fBkgClr;
      Pen.Color := fShapeClr;
      RoundRect(0, 0, Width, Height, fCorner, fCorner);
    end;

  case Self.fOrientation of
    boHorizontal:
      begin
        for i := (fBorderSize - 1) to fPosition do
        begin
          if (fByBlock) then
          begin
            if (fPosDescr[i].isInBlock = True) then
            begin
              if ((fFullBlock) and (fPosition >= fPosDescr[i].blkLimit))
                or not (fFullBlock) then
                for k := (fBorderSize - 1) to (self.Height - (fBorderSize)) do
                  Canvas.Pixels[i, k] := Self.fPixDescr[i, k]
              else if fShowInactPos then
                for k := (fBorderSize - 1) to (self.Height - (fBorderSize)) do
                  Canvas.Pixels[i, k] := fInactDescr[k];
            end;
          end
          else
          begin
            for k := (fBorderSize - 1) to (self.Height - (fBorderSize)) do
              Canvas.Pixels[i, k] := fPixDescr[i, k];
          end;
        end;

        if fShowInactPos then
        begin
          if Self.fPosition < 3 then
            sp := 3
          else
            sp := fPosition + 1;
          for i := sp to fUSefullDrawSpace do
          begin
            if (fByBlock) then
            begin
              if (fPosDescr[i].isInBlock = True) then
              begin
                for k := (fBorderSize - 1) to (self.Height - (fBorderSize)) do
                  Canvas.Pixels[i, k] := fInactDescr[k];
              end;
            end
            else
            begin
              for k := (fBorderSize - 1) to (self.Height - (fBorderSize)) do
                Canvas.Pixels[i, k] := fInactDescr[k];
            end;
          end;
        end;
      end;
    boVertical:
      begin
        for i := (fUSefullDrawSpace - 1) downto Self.height - fPosition do
        begin
          if (fByBlock) then
          begin
            if (fPosDescr[i].isInBlock = True) then
            begin
              if ((fFullBlock) and ((Self.height - fPosition) <=
                fPosDescr[i].blkLimit))
                or not (fFullBlock) then
                for k := (fBorderSize - 1) to (self.Width - (fBorderSize)) do
                  Canvas.Pixels[k, i] := Self.fPixDescr[i, k]
              else if fShowInactPos then
                for k := (fBorderSize - 1) to (self.Width - (fBorderSize)) do
                  Canvas.Pixels[k, i] := fInactDescr[k];
            end;
          end
          else
            for k := (fBorderSize - 1) to (self.Width - (fBorderSize)) do
              Canvas.Pixels[k, i] := fPixDescr[i, k];
        end;

        if fShowInactPos then
        begin
          if Self.fPosition < 3 then
            sp := Self.fUSefullDrawSpace
          else
            sp := Self.height - fPosition - 1;
          for i := sp downto fBorderSize do
          begin
            if (fByBlock) then
            begin
              if (fPosDescr[i].isInBlock = True) then
              begin
                for k := (fBorderSize - 1) to (self.Width - (fBorderSize)) do
                  Canvas.Pixels[k, i] := fInactDescr[k];
              end;
            end
            else
              for k := (fBorderSize - 1) to (self.Width - (fBorderSize)) do
                Canvas.Pixels[k, i] := fInactDescr[k];
          end;
        end;
      end;
  end;

  if fCaptionOvr then
    if fShowPosAsPct then
      SetCaption(FloatToStr(fUSerPosPct) + '%')
    else
      SetCaption(IntToStr(fUSerPos));
  if fHasCaption then
  begin
    OldBkMode := SetBkMode(Canvas.Handle, TRANSPARENT);
    with Canvas do
    begin
      Font.Assign(Self.Font);
      TextOut(fCapPos.X, fCapPos.Y, fCaption);
    end;
    SetBkMode(Canvas.Handle, OldBkMode);
  end;
end;

constructor TJcProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetLength(fPosDescr, 1);
  FPosDescr[0].IsInBlock := False;
  FByBlock := True;
  FFullBlock := False;
  FBlockSize := 5;
  FSpaceSize := 1;
  FOrientation := boHorizontal;
  FBarKind := bkCylinder;
  FBarLook := blGlass;
  DoubleBuffered := True;
  FPosition := 0;
  Width := 150;
  Height := 16;
  FHasShape := True;
  FShapeClr := TColor($00C3894B);
  FStartClr := TColor($00C3894B);
  FFinalClr := TColor($00C3894B);
  FMonoClr := True;
  FBkgClr := clWhite;
  FShowInactPos := False;
  FInactPosClr := clGray;
  FInvInactPos := False;
  FMaxPos := 100;
  FInternalBorder := 2;
  FBorderSize := 4;
  SetUsefullWidth;
  InitPixArray;
  FCorner := 5;
  FCaption := '';
  FCapPos.X := 0;
  FCapPos.Y := 0;
  FHasCaption := False;
  FCaptionOvr := False;
  FHintOvr := False;
  FShowPosAsPct := False;
  Enabled := True;
  TabStop := False;
  FStep := 10;
  //Invalidate;
  if csDesigning in ComponentState then
    self.position := 50
  else
    self.position := 0;
end;

destructor TJcProgressBar.Destroy;
begin
  SetLength(fPosDescr, 0);
  SetLength(fPixDescr, 0);
  inherited;
end;

procedure TJcProgressBar.LockInits;
begin
  self.fInitsLocked := True;
end;

procedure TJcProgressBar.UnlockInits;
begin
  Self.fInitsLocked := False;
  InitPixArray;
end;

procedure TJcProgressBar.Resize;
begin
  inherited Resize;
  fBorderSize := fInternalBorder shl 1;
  SetUsefullWidth;

  if self.fInitsLocked then
    exit;

  if fByBlock then
    InitBlockArray;
  InitPixArray;
  position := fUserPos;
end;

procedure TJcProgressBar.SetUsefullWidth;
begin
  case Self.fOrientation of
    boHorizontal: fUSefullDrawSpace := (Self.Width - (fBorderSize));
    boVertical: fUSefullDrawSpace := (Self.Height - (fBorderSize));
  end;
  fMinVisPos := fBorderSize + 1;
end;

procedure TJcProgressBar.SetFCorner(isRounded: Boolean);
begin
  if isRounded then
    Self.fCorner := 5
  else
    Self.fCorner := 0;
  Invalidate;
end;

function TJcProgressBar.GetBoolCorner: Boolean;
begin
  result := Self.fCorner > 0;
end;

procedure TJcProgressBar.SetBarKind(value: TProgressBarKind);
begin
  Self.fBarKind := value;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetBarLook(value: TProgressBarLook);
begin
  self.fBarLook := value;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetOrientation(value: TProgressBarOrientation);
var
  tmpClr: TColor;
  newH,
    newW: Integer;
begin
  LockInits;
  if value <> Self.fOrientation then
  begin
    if ((value = boVertical) and (Self.Height < Self.width))
      or ((value = boHorizontal) and (Self.width < Self.height)) then
    begin
      newW := Self.Height;
      newH := Self.Width;
      Self.Height := newH;
      Self.Width := newW;
    end;
    fOrientation := value;
    if (csDesigning in componentState) then
    begin
      tmpClr := fStartClr;
      fStartClr := fFinalClr;
      fFinalClr := tmpClr;
    end;
  end;
  case value of
    boHorizontal: if Self.Height < 10 then
        Self.fInternalBorder := 1
      else
        Self.fInternalBorder := 2;
    boVertical: if Self.Width < 10 then
        Self.fInternalBorder := 1
      else
        Self.fInternalBorder := 2;
  end;
  fBorderSize := fInternalBorder shl 1;
  SetUsefullWidth;
  Self.fInitsLocked := False;
  InitBlockArray;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetBkgColor(aColor: TColor);
begin
  Self.fBkgClr := aColor;
  Invalidate;
end;

procedure TJcProgressBar.SetShape(value: Boolean);
begin
  Self.fHasShape := value;
  Invalidate;
end;

procedure TJcProgressBar.SetShapeColor(value: TColor);
begin
  Self.fShapeClr := value;
  Invalidate;
end;

procedure TJcProgressBar.SetBlockSize(value: Integer);
begin
  case Self.fOrientation of
    boHorizontal: if value > Self.Width - (fInternalBorder shl 1) then
        Exit;
    boVertical: if value > Self.Height - (fInternalBorder shl 1) then
        Exit;
  end; {case}

  fBlockSize := Abs(value);
  fByBlock := (fBlockSize > 0) and (fSpaceSize > 0);
  if fByBlock then
    InitBlockArray;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetSpaceSize(value: Integer);
begin
  case Self.fOrientation of
    boHorizontal: if value > Self.Width - (fInternalBorder shl 1) then
        Exit;
    boVertical: if value > Self.Height - (fInternalBorder shl 1) then
        Exit;
  end; {case}

  fSpaceSize := Abs(value);
  fByBlock := (fBlockSize > 0) and (fSpaceSize > 0);
  if fByBlock then
    InitBlockArray;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetFullBlock(value: Boolean);
begin
  Self.fFullBlock := value;
  if value then
    InitBlockArray;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetMaxPos(value: Integer);
begin
  if value < 0 then
    self.fMaxPos := 0
  else
    self.fMaxPos := value;
  SetPosition(FUserPos);
  Invalidate;
end;

procedure TJcProgressBar.SetPosition(value: Integer);
var
  tmpfPos: real;
begin
  fUserPos := value;
  if fMaxPos = 0 then
    exit;
  try
    if (value <= 0) then
    begin
      self.fPosition := 0;
      fUSerPosPct := 0;
      Exit;
    end
    else if value > fMaxPos then
      value := fMaxPos;

    fUSerPosPct := Trunc((value / fMaxPos) * 100);
    tmpfPos := fUsefullDrawSpace * fUSerPosPct / 100;

    if (tmpfPos > 0.00) and (tmpfPos < fMinVisPos) then
      self.fPosition := fMinVisPos
    else if tmpfPos > fUsefullDrawSpace then
      self.fPosition := fUsefullDrawSpace
    else
      self.fPosition := Round(tmpfPos);

    if fHintOvr then
      if fShowPosAsPct then
        Hint := FloatToStr(fUSerPosPct) + ' %'
      else
        Hint := IntToStr(fUSerPos);
  finally
    DoPositionChange;
    Invalidate;
    if (fHideOnTerm) and (value = fMaxPos) then
    begin
      Sleep(100);
      Hide;
    end;
  end;
end;

procedure TJcProgressBar.SetStartClr(value: TColor);
begin
  Self.fStartClr := value;
  Self.fMonoClr := (fStartClr = fFinalClr);
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetFinalClr(value: TColor);
begin
  Self.fFinalClr := value;
  Self.fMonoClr := (fStartClr = fFinalClr);
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetBothColors(value: TColor);
begin
  Self.fMonoClr := True;
  Self.fStartClr := value;
  Self.fFinalClr := value;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetInactivePos(value: Boolean);
begin
  Self.fShowInactPos := value;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetInactPosClr(value: TColor);
begin
  Self.fInactPosClr := value;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetInvInactPos(value: Boolean);
begin
  Self.fInvInactPos := value;
  InitPixArray;
  Invalidate;
end;

procedure TJcProgressBar.SetCaption(value: string);
begin
  FCaption := Value;
  FHasCaption := not (Trim(Value) = EmptyStr);
  if FHasCaption then
  begin
    FCapPos.Y := (Height - Canvas.TextHeight('Pg')) div 2;
    case FCapAlign of
      taLeftJustify:
        begin
          FCapPos.X := 0;
        end;
      taCenter:
        begin
          FCapPos.X := (Width - Canvas.TextWidth(value)) div 2;
        end;
    else
      begin
        FCapPos.X := (Width - Canvas.TextWidth(value)) - 1;
      end;
    end;
  end;
  Invalidate;
end;

procedure TJcProgressBar.SetCapAlign(value: TAlignment);
begin
  FCapAlign := Value;
  SetCaption(FCaption);
end;

procedure TJcProgressBar.SetCaptionOvr(value: Boolean);
begin
  FCaptionOvr := value;
  Invalidate;
end;

procedure TJcProgressBar.SetStep(const Value: Integer);
begin
  if Value <> Step then
    FStep := Value;
end;

procedure TJcProgressBar.StepBy(Delta: Integer);
begin
  SetPosition(FUserPos + Delta);
end;

procedure TJcProgressBar.StepIt;
begin
  SetPosition(FUserPos + FStep);
end;

procedure TJcProgressBar.DoPositionChange;
begin
  inherited Changed;
  if Assigned(FOnPositionChange) then
    FOnPositionChange(Self);
end;

end.

