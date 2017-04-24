package cn.util.convert.converters.map;



import org.springframework.cglib.beans.BeanMap;
import cn.util.Lang;
import cn.util.convert.Converter;
import cn.util.lang.Proxys;


import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.Map;

public class ObjectToMapConverter implements Converter {
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Object convert(Object from, Class<?> toType, Object... args) {
		final Map original = from instanceof Map ? (Map) from : BeanMap
				.create(from);
		if (toType.isInterface() || Modifier.isAbstract(toType.getModifiers())) {
			return Proxys.newProxyInstance(new InvocationHandler() {
				public Object invoke(Object proxy, Method method, Object[] args)
						throws Throwable {
					return method.invoke(original, args);
				}
			}, toType);
		} else {
			try {
				Map map = (Map) toType.newInstance();
				map.putAll((Map) original);
				return map;
			} catch (InstantiationException e) {
				throw Lang.unchecked(e);
			} catch (IllegalAccessException e) {
				throw Lang.unchecked(e);
			}

		}
	}

}
