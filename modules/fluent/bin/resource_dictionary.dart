const String defaultResourceDirectionary =
    '''            <Color x:Key="TextFillColorPrimary">#FFFFFF</Color>
            <Color x:Key="TextFillColorSecondary">#C5FFFFFF</Color>
            <Color x:Key="TextFillColorTertiary">#87FFFFFF</Color>
            <Color x:Key="TextFillColorDisabled">#5DFFFFFF</Color>
            <Color x:Key="TextFillColorInverse">#E4000000</Color>

            <Color x:Key="AccentTextFillColorDisabled">#5DFFFFFF</Color>
            <Color x:Key="TextOnAccentFillColorSelectedText">#FFFFFF</Color>
            <Color x:Key="TextOnAccentFillColorPrimary">#000000</Color>
            <Color x:Key="TextOnAccentFillColorSecondary">#80000000</Color>
            <Color x:Key="TextOnAccentFillColorDisabled">#87FFFFFF</Color>

            <Color x:Key="ControlFillColorDefault">#0FFFFFFF</Color>
            <Color x:Key="ControlFillColorSecondary">#15FFFFFF</Color>
            <Color x:Key="ControlFillColorTertiary">#08FFFFFF</Color>
            <Color x:Key="ControlFillColorDisabled">#0BFFFFFF</Color>
            <Color x:Key="ControlFillColorTransparent">#00FFFFFF</Color>
            <Color x:Key="ControlFillColorInputActive">#B31E1E1E</Color>

            <Color x:Key="ControlStrongFillColorDefault">#8BFFFFFF</Color>
            <Color x:Key="ControlStrongFillColorDisabled">#3FFFFFFF</Color>

            <Color x:Key="ControlSolidFillColorDefault">#454545</Color>

            <Color x:Key="SubtleFillColorTransparent">#00FFFFFF</Color>
            <Color x:Key="SubtleFillColorSecondary">#0FFFFFFF</Color>
            <Color x:Key="SubtleFillColorTertiary">#0AFFFFFF</Color>
            <Color x:Key="SubtleFillColorDisabled">#00FFFFFF</Color>

            <Color x:Key="ControlAltFillColorTransparent">#00FFFFFF</Color>
            <Color x:Key="ControlAltFillColorSecondary">#19000000</Color>
            <Color x:Key="ControlAltFillColorTertiary">#0BFFFFFF</Color>
            <Color x:Key="ControlAltFillColorQuarternary">#12FFFFFF</Color>
            <Color x:Key="ControlAltFillColorDisabled">#00FFFFFF</Color>

            <Color x:Key="ControlOnImageFillColorDefault">#B31C1C1C</Color>
            <Color x:Key="ControlOnImageFillColorSecondary">#1A1A1A</Color>
            <Color x:Key="ControlOnImageFillColorTertiary">#131313</Color>
            <Color x:Key="ControlOnImageFillColorDisabled">#1E1E1E</Color>

            <Color x:Key="AccentFillColorDisabled">#28FFFFFF</Color>

            <Color x:Key="ControlStrokeColorDefault">#12FFFFFF</Color>
            <Color x:Key="ControlStrokeColorSecondary">#18FFFFFF</Color>
            <Color x:Key="ControlStrokeColorOnAccentDefault">#14FFFFFF</Color>
            <Color x:Key="ControlStrokeColorOnAccentSecondary">#23000000</Color>
            <Color x:Key="ControlStrokeColorOnAccentTertiary">#37000000</Color>
            <Color x:Key="ControlStrokeColorOnAccentDisabled">#33000000</Color>

            <Color x:Key="ControlStrokeColorForStrongFillWhenOnImage">#6B000000</Color>

            <Color x:Key="CardStrokeColorDefault">#19000000</Color>
            <Color x:Key="CardStrokeColorDefaultSolid">#1C1C1C</Color>

            <Color x:Key="ControlStrongStrokeColorDefault">#8BFFFFFF</Color>
            <Color x:Key="ControlStrongStrokeColorDisabled">#28FFFFFF</Color>

            <Color x:Key="SurfaceStrokeColorDefault">#66757575</Color>
            <Color x:Key="SurfaceStrokeColorFlyout">#33000000</Color>
            <Color x:Key="SurfaceStrokeColorInverse">#0F000000</Color>

            <Color x:Key="DividerStrokeColorDefault">#15FFFFFF</Color>

            <Color x:Key="FocusStrokeColorOuter">#FFFFFF</Color>
            <Color x:Key="FocusStrokeColorInner">#B3000000</Color>

            <Color x:Key="CardBackgroundFillColorDefault">#0DFFFFFF</Color>
            <Color x:Key="CardBackgroundFillColorSecondary">#08FFFFFF</Color>

            <Color x:Key="SmokeFillColorDefault">#4D000000</Color>

            <Color x:Key="LayerFillColorDefault">#4C3A3A3A</Color>
            <Color x:Key="LayerFillColorAlt">#0DFFFFFF</Color>
            <Color x:Key="LayerOnAcrylicFillColorDefault">#09FFFFFF</Color>
            <Color x:Key="LayerOnAccentAcrylicFillColorDefault">#09FFFFFF</Color>
  
            <Color x:Key="LayerOnMicaBaseAltFillColorDefault">#733A3A3A</Color>
            <Color x:Key="LayerOnMicaBaseAltFillColorSecondary">#0FFFFFFF</Color>
            <Color x:Key="LayerOnMicaBaseAltFillColorTertiary">#2C2C2C</Color>
            <Color x:Key="LayerOnMicaBaseAltFillColorTransparent">#00FFFFFF</Color>

            <Color x:Key="SolidBackgroundFillColorBase">#202020</Color>
            <Color x:Key="SolidBackgroundFillColorSecondary">#1C1C1C</Color>
            <Color x:Key="SolidBackgroundFillColorTertiary">#282828</Color>
            <Color x:Key="SolidBackgroundFillColorQuarternary">#2C2C2C</Color>
            <Color x:Key="SolidBackgroundFillColorTransparent">#00202020</Color>
            <Color x:Key="SolidBackgroundFillColorBaseAlt">#0A0A0A</Color>

            <Color x:Key="SystemFillColorSuccess">#6CCB5F</Color>
            <Color x:Key="SystemFillColorCaution">#FCE100</Color>
            <Color x:Key="SystemFillColorCritical">#FF99A4</Color>
            <Color x:Key="SystemFillColorNeutral">#8BFFFFFF</Color>
            <Color x:Key="SystemFillColorSolidNeutral">#9D9D9D</Color>
            <Color x:Key="SystemFillColorAttentionBackground">#08FFFFFF</Color>
            <Color x:Key="SystemFillColorSuccessBackground">#393D1B</Color>
            <Color x:Key="SystemFillColorCautionBackground">#433519</Color>
            <Color x:Key="SystemFillColorCriticalBackground">#442726</Color>
            <Color x:Key="SystemFillColorNeutralBackground">#08FFFFFF</Color>
            <Color x:Key="SystemFillColorSolidAttentionBackground">#2E2E2E</Color>
            <Color x:Key="SystemFillColorSolidNeutralBackground">#2E2E2E</Color>''';

const String lightResourceDictionary =
    '''            <Color x:Key="TextFillColorPrimary">#E4000000</Color>
            <Color x:Key="TextFillColorSecondary">#9E000000</Color>
            <Color x:Key="TextFillColorTertiary">#72000000</Color>
            <Color x:Key="TextFillColorDisabled">#5C000000</Color>
            <Color x:Key="TextFillColorInverse">#FFFFFF</Color>

            <Color x:Key="AccentTextFillColorDisabled">#5C000000</Color>

            <Color x:Key="TextOnAccentFillColorSelectedText">#FFFFFF</Color>

            <Color x:Key="TextOnAccentFillColorPrimary">#FFFFFF</Color>
            <Color x:Key="TextOnAccentFillColorSecondary">#B3FFFFFF</Color>
            <Color x:Key="TextOnAccentFillColorDisabled">#FFFFFF</Color>

            <Color x:Key="ControlFillColorDefault">#B3FFFFFF</Color>
            <Color x:Key="ControlFillColorSecondary">#80F9F9F9</Color>
            <Color x:Key="ControlFillColorTertiary">#4DF9F9F9</Color>
            <Color x:Key="ControlFillColorDisabled">#4DF9F9F9</Color>
            <Color x:Key="ControlFillColorTransparent">#00FFFFFF</Color>
            <Color x:Key="ControlFillColorInputActive">#FFFFFF</Color>

            <Color x:Key="ControlStrongFillColorDefault">#72000000</Color>
            <Color x:Key="ControlStrongFillColorDisabled">#51000000</Color>

            <Color x:Key="ControlSolidFillColorDefault">#FFFFFF</Color>

            <Color x:Key="SubtleFillColorTransparent">#00FFFFFF</Color>
            <Color x:Key="SubtleFillColorSecondary">#09000000</Color>
            <Color x:Key="SubtleFillColorTertiary">#06000000</Color>
            <Color x:Key="SubtleFillColorDisabled">#00FFFFFF</Color>

            <Color x:Key="ControlAltFillColorTransparent">#00FFFFFF</Color>
            <Color x:Key="ControlAltFillColorSecondary">#06000000</Color>
            <Color x:Key="ControlAltFillColorTertiary">#0F000000</Color>
            <Color x:Key="ControlAltFillColorQuarternary">#18000000</Color>
            <Color x:Key="ControlAltFillColorDisabled">#00FFFFFF</Color>

            <Color x:Key="ControlOnImageFillColorDefault">#C9FFFFFF</Color>
            <Color x:Key="ControlOnImageFillColorSecondary">#F3F3F3</Color>
            <Color x:Key="ControlOnImageFillColorTertiary">#EBEBEB</Color>
            <Color x:Key="ControlOnImageFillColorDisabled">#00FFFFFF</Color>

            <Color x:Key="AccentFillColorDisabled">#37000000</Color>

            <Color x:Key="ControlStrokeColorDefault">#0F000000</Color>
            <Color x:Key="ControlStrokeColorSecondary">#29000000</Color>
            <Color x:Key="ControlStrokeColorOnAccentDefault">#14FFFFFF</Color>
            <Color x:Key="ControlStrokeColorOnAccentSecondary">#66000000</Color>
            <Color x:Key="ControlStrokeColorOnAccentTertiary">#37000000</Color>
            <Color x:Key="ControlStrokeColorOnAccentDisabled">#0F000000</Color>

            <Color x:Key="ControlStrokeColorForStrongFillWhenOnImage">#59FFFFFF</Color>

            <Color x:Key="CardStrokeColorDefault">#0F000000</Color>
            <Color x:Key="CardStrokeColorDefaultSolid">#EBEBEB</Color>

            <Color x:Key="ControlStrongStrokeColorDefault">#72000000</Color>
            <Color x:Key="ControlStrongStrokeColorDisabled">#37000000</Color>

            <Color x:Key="SurfaceStrokeColorDefault">#66757575</Color>
            <Color x:Key="SurfaceStrokeColorFlyout">#0F000000</Color>
            <Color x:Key="SurfaceStrokeColorInverse">#15FFFFFF</Color>

            <Color x:Key="DividerStrokeColorDefault">#0F000000</Color>

            <Color x:Key="FocusStrokeColorOuter">#E4000000</Color>
            <Color x:Key="FocusStrokeColorInner">#B3FFFFFF</Color>

            <Color x:Key="CardBackgroundFillColorDefault">#B3FFFFFF</Color>
            <Color x:Key="CardBackgroundFillColorSecondary">#80F6F6F6</Color>

            <Color x:Key="SmokeFillColorDefault">#4D000000</Color>

            <Color x:Key="LayerFillColorDefault">#80FFFFFF</Color>
            <Color x:Key="LayerFillColorAlt">#FFFFFF</Color>
            <Color x:Key="LayerOnAcrylicFillColorDefault">#40FFFFFF</Color>
            <Color x:Key="LayerOnAccentAcrylicFillColorDefault">#40FFFFFF</Color>
       
            <Color x:Key="LayerOnMicaBaseAltFillColorDefault">#B3FFFFFF</Color>
            <Color x:Key="LayerOnMicaBaseAltFillColorSecondary">#0A000000</Color>
            <Color x:Key="LayerOnMicaBaseAltFillColorTertiary">#F9F9F9</Color>
            <Color x:Key="LayerOnMicaBaseAltFillColorTransparent">#00000000</Color>
            
            <Color x:Key="SolidBackgroundFillColorBase">#F3F3F3</Color>
            <Color x:Key="SolidBackgroundFillColorSecondary">#EEEEEE</Color>
            <Color x:Key="SolidBackgroundFillColorTertiary">#F9F9F9</Color>
            <Color x:Key="SolidBackgroundFillColorQuarternary">#FFFFFF</Color>
            <Color x:Key="SolidBackgroundFillColorTransparent">#00F3F3F3</Color>
            <Color x:Key="SolidBackgroundFillColorBaseAlt">#DADADA</Color>

            <Color x:Key="SystemFillColorSuccess">#0F7B0F</Color>
            <Color x:Key="SystemFillColorCaution">#9D5D00</Color>
            <Color x:Key="SystemFillColorCritical">#C42B1C</Color>
            <Color x:Key="SystemFillColorNeutral">#72000000</Color>
            <Color x:Key="SystemFillColorSolidNeutral">#8A8A8A</Color>
            <Color x:Key="SystemFillColorAttentionBackground">#80F6F6F6</Color>
            <Color x:Key="SystemFillColorSuccessBackground">#DFF6DD</Color>
            <Color x:Key="SystemFillColorCautionBackground">#FFF4CE</Color>
            <Color x:Key="SystemFillColorCriticalBackground">#FDE7E9</Color>
            <Color x:Key="SystemFillColorNeutralBackground">#06000000</Color>
            <Color x:Key="SystemFillColorSolidAttentionBackground">#F7F7F7</Color>
            <Color x:Key="SystemFillColorSolidNeutralBackground">#F3F3F3</Color>''';
