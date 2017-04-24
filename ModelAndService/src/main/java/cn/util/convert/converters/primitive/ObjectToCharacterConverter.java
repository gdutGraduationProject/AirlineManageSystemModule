package cn.util.convert.converters.primitive;


import cn.util.convert.Converter;
import cn.util.convert.Converters;

public class ObjectToCharacterConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		String string = Converters.BASE.convert(from, String.class);
		return string.length() == 1 ? string.charAt(0) : (char) 0;
	}

}
