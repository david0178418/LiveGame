package display.two.kha;

class Kha2DRenderer implements Renderer {

    #if test
    @inject
    public var graphics: mocks.MockKha2DGraphics;

    public static var fonts: Map<String, mocks.MockKhaFont>;
    #else
    @inject
    public var graphics: kha.graphics2.Graphics;

    public static var fonts: Map<String, kha.Font>;
    #end

    public var container: KhaSprite;


    public function new() {
    }

    public function init():Void {
    }

    public function dispose():Void {
        container = null;
        graphics = null;
    }

    public function render():Void {
        renderChildren(container, container.x, container.y);
    }

    private inline function renderChildren(container: KhaSprite, xPos: Float, yPos: Float) {
        var children = container.children;
        for(child in children) {
            if(Std.is(child, KhaSprite)) {
                renderChildren(cast child, child.x + xPos, child.y + yPos);
            } else {
                if(Std.is(child, KhaBitmapNode)) {
                    var bitmap: KhaBitmapNode = cast child;
                    if(bitmap.imageData != null) {
                        graphics.drawSubImage(bitmap.imageData, bitmap.x + xPos, bitmap.y + yPos, bitmap.sx, bitmap.sy,
                        bitmap.sw, bitmap.sh);
                    }
                } else {
                    var textField: KhaTextFieldNode = cast child;
                    graphics.fontSize = textField.fontSize;
                    graphics.color = getColorFromValue(textField.fontColor);
                    graphics.font = fonts.get(textField.fontName);
                    graphics.drawString(textField.text, textField.x + xPos, textField.y + yPos);
                    graphics.color = getWhite();
                }
            }
        }
    }

    #if test
    private inline function getColorFromValue(value: UInt): mocks.MockColor {
        return new mocks.MockColor();
    }

    private inline function getWhite():mocks.MockColor {
        return new mocks.MockColor();
    }
    #else
    private inline function getColorFromValue(value: UInt): kha.Color {
        return kha.Color.fromValue(value);
    }
    private inline function getWhite(): kha.Color {
        return kha.Color.White;
    }
    #end
}
