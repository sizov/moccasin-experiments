package com.joeberkovitz.simpleworld.persistence
{
    import com.joeberkovitz.moccasin.model.ModelRoot;
    import com.joeberkovitz.moccasin.persistence.IDocumentEncoder;
    import com.joeberkovitz.simpleworld.model.WorldShape;
    import com.joeberkovitz.simpleworld.model.Square;
    import com.joeberkovitz.simpleworld.model.World;

    /**
     * Application specific document encoder converting a top-level model into XML.
     */
    public class AppDocumentEncoder implements IDocumentEncoder
    {
        public function AppDocumentEncoder()
        {
        }

        public function encodeDocument(root:ModelRoot):*
        {
            var world:World = root.value as World;
            var xml:XML = <world/>;
            
            for each (var shape:WorldShape in world.shapes)
            {
                if (shape is Square)
                {
                    var square:Square = shape as Square;
                    xml.appendChild(<square x={square.x} y={square.y} size={square.size}/>);
                }
            }
            
            return xml;
        }
     }
}