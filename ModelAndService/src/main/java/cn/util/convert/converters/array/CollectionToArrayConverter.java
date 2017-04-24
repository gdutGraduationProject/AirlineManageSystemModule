package cn.util.convert.converters.array;



import cn.util.Lang;
import cn.util.convert.Converter;
import cn.util.convert.Converters;

import java.lang.reflect.Array;
import java.util.Collection;

public class CollectionToArrayConverter implements Converter {

	public Object convert(Object from, Class<?> toType, Object... args) {
		Collection<?> collection = (Collection<?>) from;
		try {
			Object array = Array.newInstance(toType.getComponentType(),
					collection.size());
			int i = 0;
			for (Object object : collection) {
				Array.set(
						array,
						i,
						Converters.BASE.convert(object,
								toType.getComponentType()));
				i++;
			}
			return array;
		} catch (Exception e) {
			throw Lang.unchecked(e);
		}
	}

}
