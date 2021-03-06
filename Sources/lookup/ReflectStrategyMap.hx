package lookup;
import handler.input.UnitCreated;
import handler.input.UnitMove;
import handler.actions.UnitMoveAction;
import handler.actions.UnitCreatedAction;
import haxe.ds.ObjectMap;
import handler.actions.PlayerConnectedAction;
import handler.input.PlayerConnected;
import core.ObjectCreator;
import handler.StrategyMap;
import handler.IOHandler;
import handler.StrategyAction;
class ReflectStrategyMap implements StrategyMap {
    @inject
    public var objectCreator: ObjectCreator;

    public var handlerMap: ObjectMap<Dynamic, StrategyAction>;

    public function new() {
    }

    public function init():Void {
        handlerMap = new ObjectMap<Dynamic, StrategyAction>();

        handlerMap.set(PlayerConnected, objectCreator.createInstance(PlayerConnectedAction));
        handlerMap.set(UnitCreated, objectCreator.createInstance(UnitCreatedAction));
        handlerMap.set(UnitMove, objectCreator.createInstance(UnitMoveAction));
    }

    public function dispose():Void {
    }

    public function locate(handler:IOHandler):StrategyAction {
        return handlerMap.get(Type.getClass(handler));
    }

}
