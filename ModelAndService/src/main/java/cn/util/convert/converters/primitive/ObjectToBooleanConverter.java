package cn.util.convert.converters.primitive;


import cn.util.convert.Converter;
import cn.util.convert.Converters;

public class ObjectToBooleanConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		String string = Converters.BASE.convert(from, String.class);
		return Boolean.valueOf(string);
	}

}
